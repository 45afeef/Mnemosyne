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
    ):
        techniques = [item.name for item in self.repository.get_all_techniques()]

        assessments = [item.name for item in self.repository.get_all_assessments()]

        prompt = (
            self.prompt_builder
            .build_lesson_prompt(
                goal=request.goal,
                topic=request.topic,
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
            lesson_items=result_payload.get("lesson_items", []),
        )



    # ======================================================
    # 3. GENERATE NEW TECHNIQUE ITEM
    # ======================================================


    async def generate_technique_item(
        self,
        request: TechniqueRequest,
    ):

        all_techniques = [
            item.name
            for item in self.repository.get_all_techniques()
        ]

        if not all_techniques:
            raise ValueError("No technique definitions available")

        technique_pool = [
            name
            for name in all_techniques
            if name not in request.previous_items
        ]

        if not technique_pool:
            technique_pool = all_techniques

        prompt = (
            self.prompt_builder
            .build_technique_prompt(
                goal=request.topic,
                topic=request.topic,
                technique_pool=technique_pool,
                preferred_techniques=request.preferred_techniques,
            )
        )

        result = await ai_service.generate(
            prompt,
            json_mode=True,
        )

        result_payload = result if isinstance(result, dict) else {}

        return {
            "name": result_payload.get("name", "Technique"),
            "markdown": result_payload.get("markdown", ""),
        }



    # ======================================================
    # 4. GENERATE NEW ASSESSMENT ITEM
    # ======================================================


    async def generate_assessment_item(
        self,
        request: AssessmentRequest,
    ):

        all_assessments = [
            item.name
            for item in self.repository.get_all_assessments()
        ]

        if not all_assessments:
            raise ValueError("No assessment definitions available")

        assessment_pool = [
            name
            for name in all_assessments
            if name not in request.previous_items
        ]

        if not assessment_pool:
            assessment_pool = all_assessments

        prompt = (
            self.prompt_builder
            .build_assessment_prompt(
                goal=request.topic,
                topic=request.topic,
                assessment_pool=assessment_pool,
                preferred_assessments=request.preferred_assessments,
            )
        )

        result = await ai_service.generate(
            prompt,
            json_mode=True,
        )

        result_payload = result if isinstance(result, dict) else {}

        return {
            "name": result_payload.get("name", "Assessment"),
            "content": result_payload.get("content", {}),
        }