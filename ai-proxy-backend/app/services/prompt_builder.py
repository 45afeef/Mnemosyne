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
        goal_name: str,
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
            goal_name = goal_name,

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

        return "\n".join(rendered)

    @staticmethod
    def build_lesson_prompt(
        goal: str,
        topic: str,
        techniques: List[str],
        assessments: List[str],
        learning_items: List[LearningItemRequest],
    ) -> str:


        technique_text = ",".join(techniques)

        assessment_text = ",".join(assessments)

        learning_items_text = PromptBuilder._render_learning_items(learning_items)


        return LESSON_SESSION_PROMPT.format(
            goal=goal,
            topic=topic,
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
    def _render_pool(items: List[str]) -> str:
        return "\n".join(f"- {item}" for item in items)

    @staticmethod
    def build_technique_prompt(
        goal: str,
        topic: str,
        technique_pool: List[str],
        preferred_techniques: List[str],
    ) -> str:

        pool_text = PromptBuilder._render_pool(technique_pool)
        preferred_text = (
            "\nPreferred techniques:\n" + PromptBuilder._render_pool(preferred_techniques)
            if preferred_techniques
            else ""
        )

        return TECHNIQUE_GENERATION_PROMPT.format(
            goal=goal,
            topic=topic,
            technique_pool=pool_text,
            preferred_techniques=preferred_text,
        )


    # ======================================================
    # ASSESSMENT
    # ======================================================

    @staticmethod
    def build_assessment_prompt(
        goal: str,
        topic: str,
        assessment_pool: List[str],
        preferred_assessments: List[str],
    ) -> str:

        pool_text = PromptBuilder._render_pool(assessment_pool)
        preferred_text = (
            "\nPreferred assessments:\n" + PromptBuilder._render_pool(preferred_assessments)
            if preferred_assessments
            else ""
        )

        return ASSESSMENT_GENERATION_PROMPT.format(
            goal=goal,
            topic=topic,
            assessment_pool=pool_text,
            preferred_assessments=preferred_text,
        )