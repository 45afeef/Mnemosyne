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


class TechniqueContentResponse(BaseModel):
    """
    A technique block inside a lesson item.
    """

    model_config = ConfigDict(extra="forbid")

    name: str

    markdown: str


class AssessmentContentResponse(BaseModel):
    """
    An assessment block inside a lesson item.
    """

    model_config = ConfigDict(extra="forbid")

    name: str

    content: dict


class SessionLearningItemResponse(BaseModel):
    """
    One lesson item in the session, with techniques and one assessment.
    """

    model_config = ConfigDict(extra="forbid")

    name: str

    description: Optional[str] = None

    techniques: List[TechniqueContentResponse] = Field(default_factory=list)

    assessments: List[AssessmentContentResponse] = Field(default_factory=list)


class LessonSessionResponse(BaseModel):
    """
    Lesson session built from ordered lesson items with techniques and assessments.
    """

    model_config = ConfigDict(extra="forbid")

    topic: str

    lesson_items: List[SessionLearningItemResponse] = Field(default_factory=list)


# ==========================================================
# TECHNIQUE RESPONSE
# ==========================================================


class TechniqueResponse(BaseModel):
    """
    Generated technique content.
    """

    model_config = ConfigDict(extra="forbid")

    name: str

    markdown: str


# ==========================================================
# ASSESSMENT RESPONSE
# ==========================================================


class AssessmentResponse(BaseModel):
    """
    Generated assessment content.
    """

    model_config = ConfigDict(extra="forbid")

    name: str

    content: dict