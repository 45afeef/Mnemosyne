"""
This file converts your database-driven learning configuration into prompts.

Responsibilities:

Accept objects from repository.py
Extract useful learning metadata
Fill templates from core/prompts.py
Return ready-to-send prompts

It does not:

Query PostgreSQL
Call the LLM
Decide which technique/assessment to select

"""

from typing import List

from app.core.prompts import (
    LESSON_SESSION_PROMPT,
    SYLLABUS_GENERATION_PROMPT,
    TECHNIQUE_GENERATION_PROMPT,
    ASSESSMENT_GENERATION_PROMPT,
)

from app.db.models import (
    Assessment,
    Stage,
    StageDefinition,
    Taxonomy,
    Technique,
)
from app.schemas.requests import LearningItemRequest


class PromptBuilder:
    """
    Converts learning configuration data into AI prompts.
    """

    # ======================================================
    # SYLLABUS
    # ======================================================

    @staticmethod
    def build_syllabus_prompt(
        goal_description: str,
        taxonomy: Taxonomy,
        stages: List[Stage],
    ) -> str:

        stage_text = "\n\n".join(
            [
                """
Stage:
{name}

Order:
{order}

Description:
{description}
""".format(
                    name=stage.name,
                    order=stage.order,
                    description=stage.description or "",
                )
                for stage in stages
            ]
        )

        return SYLLABUS_GENERATION_PROMPT.format(
            goal_description=goal_description,

            name=taxonomy.name,

            taxonomy_description=(
                taxonomy.description or ""
            ),

            stages=stage_text,
        )


    # ======================================================
    # LESSON SESSION
    # ======================================================

    @staticmethod
    def _render_learning_items(
        items: List[LearningItemRequest],
    ) -> str:
        rendered: List[str] = []

        for item in items:
            rendered.append(
                f"Name: {item.name}\n"
                f"Description: {item.description or ''}\n"
                f"Content: {item.content or ''}"
            )

            # only the last leaf learning item will be considered to create lesson session so even if the client provide nested only only the high level is considered

        return "\n".join(rendered)

    @staticmethod
    def build_lesson_prompt(
        goal: str,
        topic: str,
        stage: Stage,
        stage_definition: StageDefinition,
        techniques: List[Technique],
        assessments: List[Assessment],
        learning_items: List[LearningItemRequest],
    ) -> str:


        technique_text = ",".join(
            [
                "{name}".format(
                    name=t.name,
                )
                for t in techniques
            ]
        )


        assessment_text = ",".join(
            [
                "{name}".format(
                    name=a.name,
                )
                for a in assessments
            ]
        )

        learning_items_text = PromptBuilder._render_learning_items(learning_items)


        return LESSON_SESSION_PROMPT.format(
            goal=goal,

            topic=topic,

            stage=stage.name,

            learning_items=(
                learning_items_text
                or "No source learning items provided."
            ),

            techniques=technique_text,

            assessments=assessment_text,
        )


    # ======================================================
    # TECHNIQUE
    # ======================================================

    @staticmethod
    def build_technique_prompt(
        goal: str,
        topic: str,
        technique: Technique,
    ) -> str:

        return TECHNIQUE_GENERATION_PROMPT.format(

            goal=goal,

            topic=topic,

            technique_name=technique.name,

            category=technique.category.value,

            purpose=technique.purpose,

            description=technique.description,

            difficulty=technique.difficulty,

            estimated_time=(
                technique.estimated_time
            ),
        )


    # ======================================================
    # ASSESSMENT
    # ======================================================

    @staticmethod
    def build_assessment_prompt(
        goal: str,
        topic: str,
        assessment: Assessment,
    ) -> str:

        return ASSESSMENT_GENERATION_PROMPT.format(

            goal=goal,

            topic=topic,

            name=assessment.name,

            category=assessment.category.value,

            description=assessment.description,

            difficulty=assessment.difficulty,
        )