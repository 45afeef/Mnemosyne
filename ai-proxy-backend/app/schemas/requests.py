from __future__ import annotations

from typing import List, Optional

from pydantic import BaseModel, ConfigDict, Field


# ==========================================================
# LEARNING GOAL
# ==========================================================


class LearningGoalRequest(BaseModel):
    """
    User creates a learning goal.
    """

    model_config = ConfigDict(extra="forbid")

    name: str = Field(
        ...,
    )

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
# RECURSIVE LEARNING ITEMS
# ==========================================================


class LearningItemRequest(BaseModel):
    """
    Recursive learning item used by the syllabus tree and lesson session.
    """

    model_config = ConfigDict(extra="forbid")

    name: str

    description: Optional[str] = None

    content: Optional[str] = None


# ==========================================================
# LESSON SESSION
# ==========================================================


class LessonSessionRequest(BaseModel):
    """
    Generate a lesson session for a topic using the leaf learning items.
    """

    model_config = ConfigDict(extra="forbid")

    goal: str

    topic: str

    learning_items: List[LearningItemRequest] = Field(default_factory=list)


# ==========================================================
# TECHNIQUE ADD-ON
# ==========================================================


class TechniqueRequest(BaseModel):
    """
    User requests another technique.
    """

    model_config = ConfigDict(extra="forbid")

    topic: str

    previous_items: List[str] = Field(
        default_factory=list,
        description="Previously generated technique names to avoid repetition.",
    )

    preferred_techniques: List[str] = Field(
        default_factory=list,
        description="Optional preferred technique names in human-friendly form.",
    )


# ==========================================================
# ASSESSMENT ADD-ON
# ==========================================================


class AssessmentRequest(BaseModel):
    """
    User requests another assessment.
    """

    model_config = ConfigDict(extra="forbid")

    topic: str

    previous_items: List[str] = Field(
        default_factory=list,
        description="Previously generated assessment names to avoid repetition.",
    )

    preferred_assessments: List[str] = Field(
        default_factory=list,
        description="Optional preferred assessment names in human-friendly form.",
    )