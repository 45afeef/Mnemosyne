"""
This will be the largest and most important file, tying together the repository, prompt builder, and AI.
This is the core business layer.

Responsibilities:
Connect repository data with prompt generation.
Decide the workflow for each endpoint.
Call the AI service.
Return structured results.

It does not:

Handle HTTP requests.
Know FastAPI.
Write SQL.
Build raw prompts.

The flow:

API Route
    |
    v
LearningService
    |
    +--> Repository (PostgreSQL)
    |
    +--> PromptBuilder
    |
    +--> AIService
    |
    v
Response

"""

from typing import List

from sqlalchemy.orm import Session

from app.db.repository import LearningRepository
from app.services.ai import ai_service
from app.services.prompt_builder import PromptBuilder

from app.schemas.requests import (
    LearningGoalRequest,
    LessonSessionRequest,
    TechniqueRequest,
    AssessmentRequest,
)
from app.schemas.responses import (
    LessonSessionResponse,
    SyllabusResponse,
)


class LearningService:
    """
    Main business logic for AI learning generation.
    """


    def __init__(self, db: Session):

        self.repository = LearningRepository(db)

        self.prompt_builder = PromptBuilder



    # ======================================================
    # 1. GENERATE SYLLABUS FROM GOAL
    # ======================================================

    async def generate_syllabus_from_goal(
        self,
        request: LearningGoalRequest,
        taxonomy_id: int,
    ):

        taxonomy = (
            self.repository.get_taxonomy(
                taxonomy_id
            )
        )

        if not taxonomy:
            raise ValueError(
                "Taxonomy not found"
            )


        stages = (
            self.repository.get_stages(
                taxonomy_id
            )
        )


        prompt = (
            self.prompt_builder
            .build_syllabus_prompt(
                goal_description=(
                    request.description
                ),
                taxonomy=taxonomy,
                stages=stages,
            )
        )


        result = await ai_service.generate(
            prompt,
            json_mode=True,
        )

        result_payload = result if isinstance(result, dict) else {}

        return SyllabusResponse(
            goal_description=request.description,
            taxonomy_name=taxonomy.name,
            subjects=result_payload.get("subjects", []),
        )



    # ======================================================
    # 2. GENERATE LESSON SESSION
    # ======================================================


    async def generate_lesson_session(
        self,
        request: LessonSessionRequest,
        stage_id: int,
    ):


        stage_definition = (
            self.repository
            .get_stage_definition(
                stage_id
            )
        )


        if not stage_definition:

            raise ValueError(
                "Stage definition not found"
            )



        stage = stage_definition.stage



        stage_techniques = (
            self.repository
            .get_stage_techniques(
                stage_definition.id
            )
        )


        techniques = [
            item.technique
            for item in stage_techniques
        ]



        # Collect assessments attached
        # to available techniques

        assessments = []


        for technique in techniques:

            items = (
                self.repository
                .get_assessments_for_technique(
                    technique.id
                )
            )

            assessments.extend(
                [
                    x.assessment
                    for x in items
                ]
            )



        prompt = (
            self.prompt_builder
            .build_lesson_prompt(
                goal=request.goal,
                topic=request.topic,
                stage=stage,
                stage_definition=(
                    stage_definition
                ),
                techniques=techniques,
                assessments=assessments,
                learning_items=request.learning_items,
            )
        )


        result = await ai_service.generate(
            prompt,
            json_mode=True,
        )

        result_payload = result if isinstance(result, dict) else {}

        return LessonSessionResponse(
            topic=request.topic,
            stage=stage.name,
            learning_items=result_payload.get("learning_items", []),
        )



    # ======================================================
    # 3. GENERATE NEW TECHNIQUE ITEM
    # ======================================================


    async def generate_technique_item(
        self,
        request: TechniqueRequest,
    ):


        technique = (
            self.repository
            .get_best_technique(
                request.stage_definition_id,
                request.previous_items,
            )
        )


        if not technique:

            raise ValueError(
                "No new technique available"
            )


        prompt = (
            self.prompt_builder
            .build_technique_prompt(
                topic=request.topic,
                technique=technique,
            )
        )



        result = await ai_service.generate(
            prompt
        )



        return {
            "technique_id": technique.id,
            "technique_name": technique.name,
            "category": (
                technique.category.value
            ),
            "markdown": result,
        }



    # ======================================================
    # 4. GENERATE NEW ASSESSMENT ITEM
    # ======================================================


    async def generate_assessment_item(
        self,
        request: AssessmentRequest,
    ):


        assessment = (
            self.repository
            .get_best_assessment(
                request.technique_id,
                request.previous_items,
            )
        )


        if not assessment:

            raise ValueError(
                "No new assessment available"
            )



        prompt = (
            self.prompt_builder
            .build_assessment_prompt(
                topic=request.topic,
                assessment=assessment,
            )
        )



        result = await ai_service.generate(
            prompt,
            json_mode=True,
        )



        return {
            "assessment_id": assessment.id,
            "assessment_name": (
                assessment.name
            ),
            "category": (
                assessment.category.value
            ),
            "content": result,
        }