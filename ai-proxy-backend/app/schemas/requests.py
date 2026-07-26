from typing import List, Optional

from pydantic import BaseModel, Field


# ==========================================================
# LEARNING GOAL
# ==========================================================


class LearningGoalRequest(BaseModel):
    """
    User creates a learning goal.
    """

    description: str = Field(
        ...,
        description="Learning goal written by user",
    )

    end_date: Optional[str] = Field(
        default=None,
        description="Optional target completion date",
    )

    understand: Optional[int] = Field(
        default=None,
        ge=0,
        le=5,
        description="Understanding level 0-5",
    )

    memorize: Optional[int] = Field(
        default=None,
        ge=0,
        le=5,
        description="Memorization level 0-5",
    )



# ==========================================================
# LESSON SESSION
# ==========================================================


class LessonSessionRequest(BaseModel):
    """
    Generate a lesson session for a topic.
    """

    goal_id: str

    goal: str

    topic: str



# ==========================================================
# TECHNIQUE ADD-ON
# ==========================================================


class TechniqueRequest(BaseModel):
    """
    User requests another technique.
    """

    goal_id: str

    topic: str

    stage_definition_id: int

    previous_items: List[str] = Field(
        default_factory=list
    )



# ==========================================================
# ASSESSMENT ADD-ON
# ==========================================================


class AssessmentRequest(BaseModel):
    """
    User requests another assessment.
    """

    goal_id: str

    topic: str

    technique_id: int

    previous_items: List[str] = Field(
        default_factory=list
    )