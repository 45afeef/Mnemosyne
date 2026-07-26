from __future__ import annotations

from typing import List, Optional

from pydantic import BaseModel, ConfigDict, Field


# ==========================================================
# GOAL / SYLLABUS
# ==========================================================


class LearningItemResponse(BaseModel):
    """
    Recursive learning item used in the syllabus tree and lesson session.
    """

    model_config = ConfigDict(extra="forbid")

    id: Optional[str] = None

    name: str

    description: Optional[str] = None

    content: Optional[str] = None

    learning_items: List["LearningItemResponse"] = Field(default_factory=list)


class ModuleResponse(BaseModel):
    """
    A module inside a subject.
    """

    model_config = ConfigDict(extra="forbid")

    id: Optional[str] = None

    name: str

    description: Optional[str] = None

    learning_items: List[LearningItemResponse] = Field(default_factory=list)


class SubjectResponse(BaseModel):
    """
    A subject inside the syllabus tree.
    """

    model_config = ConfigDict(extra="forbid")

    id: Optional[str] = None

    name: str

    description: Optional[str] = None

    modules: List[ModuleResponse] = Field(default_factory=list)


class SyllabusResponse(BaseModel):
    """
    Full syllabus tree built from the user goal and taxonomy.
    """

    model_config = ConfigDict(extra="forbid")

    goal_description: str

    taxonomy_name: str

    subjects: List[SubjectResponse] = Field(default_factory=list)


# ==========================================================
# LESSON SESSION
# ==========================================================


class LessonSessionResponse(BaseModel):
    """
    Lesson session built from the leaf learning items.
    """

    model_config = ConfigDict(extra="forbid")

    topic: str

    stage: Optional[str] = None

    learning_items: List[LearningItemResponse] = Field(default_factory=list)


# ==========================================================
# TECHNIQUE RESPONSE
# ==========================================================


class TechniqueResponse(BaseModel):
    """
    Generated technique content.
    """

    model_config = ConfigDict(extra="forbid")

    technique_id: int

    technique_name: str

    category: str

    markdown: str


# ==========================================================
# ASSESSMENT RESPONSE
# ==========================================================


class AssessmentResponse(BaseModel):
    """
    Generated assessment content.
    """

    model_config = ConfigDict(extra="forbid")

    assessment_id: int

    assessment_name: str

    category: str

    content: dict