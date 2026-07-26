from typing import List, Optional, Literal

from pydantic import BaseModel


# ==========================================================
# GOAL / SYLLABUS
# ==========================================================


class TopicResponse(BaseModel):

    id: Optional[str] = None

    name: str

    description: Optional[str] = None



class SyllabusResponse(BaseModel):

    goal_id: str

    description: str

    topics: List[TopicResponse]



# ==========================================================
# LEARNING ITEMS
# ==========================================================


LearningItemType = Literal[
    "technique",
    "assessment",
]



class LearningItemResponse(BaseModel):

    type: LearningItemType

    name: str

    category: Optional[str] = None

    markdown: Optional[str] = None

    metadata: Optional[dict] = None



# ==========================================================
# LESSON SESSION
# ==========================================================


class LessonSessionResponse(BaseModel):

    goal_id: str

    topic: str

    stage: Optional[str] = None

    learning_items: List[LearningItemResponse]



# ==========================================================
# TECHNIQUE RESPONSE
# ==========================================================


class TechniqueResponse(BaseModel):

    technique_id: int

    technique_name: str

    category: str

    markdown: str



# ==========================================================
# ASSESSMENT RESPONSE
# ==========================================================


class AssessmentResponse(BaseModel):

    assessment_id: int

    assessment_name: str

    category: str

    content: dict