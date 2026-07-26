from typing import List, Literal, Optional

from pydantic import BaseModel


TechniqueType = Literal[
    "analogy",
    "example",
    "metaphor",
    "comparison",
]

AssessmentType = Literal[
    "mcq",
    "essay",
    "fill_in_blank",
    "true_false",
]


class LearningGoalRequest(BaseModel):
    description: str
    end_date: Optional[str] = None
    understand: Optional[int] = None
    memorize: Optional[int] = None


class LessonSessionRequest(BaseModel):
    goal_id: str
    goal: str
    topic: str


class TechniqueRequest(BaseModel):
    goal: str
    topic: str
    technique: TechniqueType
    previous_items: List[str] = []


class AssessmentRequest(BaseModel):
    goal: str
    topic: str
    assessment: AssessmentType
    previous_items: List[str] = []