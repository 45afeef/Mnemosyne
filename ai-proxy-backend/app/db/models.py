from enum import Enum
from typing import List, Optional

from sqlalchemy import (
    Boolean,
    Enum as SQLEnum,
    Float,
    ForeignKey,
    Integer,
    String,
    Text,
)
from sqlalchemy.orm import (
    Mapped,
    mapped_column,
    relationship,
)

from app.db.base import Base


# ==========================================================
# ENUMS
# ==========================================================


class TechniqueCategory(str, Enum):
    UNDERSTAND = "Understand"
    MEMORIZATION = "Memorization"
    PRACTICE = "Practice"
    VISUALIZATION = "Visualization"
    RECALL = "Recall"


class AssessmentCategory(str, Enum):
    RECOGNITION = "Recognition"
    RECALL = "Recall"
    APPLICATION = "Application"
    GAME = "Game"


# ==========================================================
# TAXONOMY
# ==========================================================


class Taxonomy(Base):
    __tablename__ = "taxonomy"

    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
    )

    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )

    description: Mapped[Optional[str]] = mapped_column(
        Text,
        nullable=True,
    )


    stages: Mapped[List["Stage"]] = relationship(
        back_populates="taxonomy",
        cascade="all, delete-orphan",
    )


# ==========================================================
# STAGE
# ==========================================================


class Stage(Base):
    __tablename__ = "stage"


    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
    )


    taxonomy_id: Mapped[int] = mapped_column(
        ForeignKey("taxonomy.id"),
        nullable=False,
        index=True,
    )


    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )


    order: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )


    description: Mapped[Optional[str]] = mapped_column(
        Text,
        nullable=True,
    )


    taxonomy: Mapped["Taxonomy"] = relationship(
        back_populates="stages",
    )


    definitions: Mapped[List["StageDefinition"]] = relationship(
        back_populates="stage",
        cascade="all, delete-orphan",
    )



# ==========================================================
# STAGE DEFINITION
# ==========================================================


class StageDefinition(Base):
    __tablename__ = "stage_definition"


    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
    )


    stage_id: Mapped[int] = mapped_column(
        ForeignKey("stage.id"),
        nullable=False,
        index=True,
    )


    summary: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )


    stage: Mapped["Stage"] = relationship(
        back_populates="definitions",
    )


    stage_techniques: Mapped[List["StageTechnique"]] = relationship(
        back_populates="stage_definition",
        cascade="all, delete-orphan",
    )



# ==========================================================
# TECHNIQUE
# ==========================================================


class Technique(Base):
    __tablename__ = "technique"


    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
    )


    category: Mapped[TechniqueCategory] = mapped_column(
        SQLEnum(TechniqueCategory),
        nullable=False,
        index=True,
    )


    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )


    description: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )


    purpose: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )


    difficulty: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )


    estimated_time: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )


    supports_ai: Mapped[bool] = mapped_column(
        Boolean,
        default=True,
    )


    stage_links: Mapped[List["StageTechnique"]] = relationship(
        back_populates="technique",
    )


    assessments: Mapped[List["TechniqueAssessment"]] = relationship(
        back_populates="technique",
    )



# ==========================================================
# STAGE TECHNIQUE
# ==========================================================


class StageTechnique(Base):
    __tablename__ = "stage_technique"


    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
    )


    stage_definition_id: Mapped[int] = mapped_column(
        ForeignKey("stage_definition.id"),
        nullable=False,
        index=True,
    )


    technique_id: Mapped[int] = mapped_column(
        ForeignKey("technique.id"),
        nullable=False,
        index=True,
    )


    weight: Mapped[float] = mapped_column(
        Float,
        nullable=False,
        default=1.0,
    )


    stage_definition: Mapped["StageDefinition"] = relationship(
        back_populates="stage_techniques",
    )


    technique: Mapped["Technique"] = relationship(
        back_populates="stage_links",
    )



# ==========================================================
# ASSESSMENT
# ==========================================================


class Assessment(Base):
    __tablename__ = "assessment"


    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
    )


    name: Mapped[str] = mapped_column(
        String(100),
        nullable=False,
    )


    category: Mapped[AssessmentCategory] = mapped_column(
        SQLEnum(AssessmentCategory),
        nullable=False,
        index=True,
    )


    description: Mapped[str] = mapped_column(
        Text,
        nullable=False,
    )


    difficulty: Mapped[int] = mapped_column(
        Integer,
        nullable=False,
    )


    supports_ai: Mapped[bool] = mapped_column(
        Boolean,
        default=True,
    )


    techniques: Mapped[List["TechniqueAssessment"]] = relationship(
        back_populates="assessment",
    )



# ==========================================================
# TECHNIQUE ASSESSMENT
# ==========================================================


class TechniqueAssessment(Base):
    __tablename__ = "technique_assessment"


    id: Mapped[int] = mapped_column(
        Integer,
        primary_key=True,
    )


    technique_id: Mapped[int] = mapped_column(
        ForeignKey("technique.id"),
        nullable=False,
        index=True,
    )


    assessment_id: Mapped[int] = mapped_column(
        ForeignKey("assessment.id"),
        nullable=False,
        index=True,
    )


    weight: Mapped[float] = mapped_column(
        Float,
        nullable=False,
        default=1.0,
    )


    technique: Mapped["Technique"] = relationship(
        back_populates="assessments",
    )


    assessment: Mapped["Assessment"] = relationship(
        back_populates="techniques",
    )