# This file is responsible only for reading admin-managed learning configuration from PostgreSQL.

# The service layer will call this file, but it will not know SQL exists.

# Responsibilities:

# Find taxonomy/stages
# Load stage definitions
# Load allowed techniques
# Load allowed assessments
# Pick weighted techniques/assessments
# Avoid previously generated items

# No AI logic belongs here.

from typing import List, Optional

from sqlalchemy import select
from sqlalchemy.orm import Session, joinedload

from app.db.models import (
    Assessment,
    Stage,
    StageDefinition,
    StageTechnique,
    Taxonomy,
    Technique,
    TechniqueAssessment,
)


class LearningRepository:
    """
    Database access layer for learning configuration.
    """

    def __init__(self, db: Session):
        self.db = db


    # ======================================================
    # TAXONOMY
    # ======================================================

    def get_taxonomy(
        self,
        taxonomy_id: int,
    ) -> Optional[Taxonomy]:

        statement = (
            select(Taxonomy)
            .where(
                Taxonomy.id == taxonomy_id
            )
            .options(
                joinedload(Taxonomy.stages)
            )
        )

        return self.db.scalar(statement)



    # ======================================================
    # STAGES
    # ======================================================

    def get_stages(
        self,
        taxonomy_id: int,
    ) -> List[Stage]:

        statement = (
            select(Stage)
            .where(
                Stage.taxonomy_id == taxonomy_id
            )
            .order_by(
                Stage.order
            )
        )

        return list(
            self.db.scalars(statement)
        )



    def get_stage_definition(
        self,
        stage_id: int,
    ) -> Optional[StageDefinition]:

        statement = (
            select(StageDefinition)
            .where(
                StageDefinition.stage_id == stage_id
            )
            .options(
                joinedload(
                    StageDefinition.stage_techniques
                )
                .joinedload(
                    StageTechnique.technique
                )
            )
        )

        return self.db.scalar(statement)



    # ======================================================
    # TECHNIQUES
    # ======================================================


    def get_stage_techniques(
        self,
        stage_definition_id: int,
    ) -> List[StageTechnique]:

        statement = (
            select(StageTechnique)
            .where(
                StageTechnique.stage_definition_id
                == stage_definition_id
            )
            .options(
                joinedload(
                    StageTechnique.technique
                )
            )
            .order_by(
                StageTechnique.weight.desc()
            )
        )

        return list(
            self.db.scalars(statement)
        )



    def get_available_techniques(
        self,
        stage_definition_id: int,
        previous_items: List[str],
    ) -> List[Technique]:

        stage_techniques = self.get_stage_techniques(
            stage_definition_id
        )

        techniques = []

        for item in stage_techniques:

            technique = item.technique

            if technique.name not in previous_items:
                techniques.append(
                    technique
                )

        return techniques



    # ======================================================
    # ASSESSMENTS
    # ======================================================


    def get_assessments_for_technique(
        self,
        technique_id: int,
    ) -> List[TechniqueAssessment]:

        statement = (
            select(TechniqueAssessment)
            .where(
                TechniqueAssessment.technique_id
                == technique_id
            )
            .options(
                joinedload(
                    TechniqueAssessment.assessment
                )
            )
            .order_by(
                TechniqueAssessment.weight.desc()
            )
        )

        return list(
            self.db.scalars(statement)
        )



    def get_available_assessments(
        self,
        technique_id: int,
        previous_items: List[str],
    ) -> List[Assessment]:

        technique_assessments = (
            self.get_assessments_for_technique(
                technique_id
            )
        )

        assessments = []

        for item in technique_assessments:

            assessment = item.assessment

            if assessment.name not in previous_items:
                assessments.append(
                    assessment
                )

        return assessments



    # ======================================================
    # WEIGHTED SELECTION HELPERS
    # ======================================================


    def get_best_technique(
        self,
        stage_definition_id: int,
        previous_items: List[str] = [],
    ) -> Optional[Technique]:

        techniques = self.get_available_techniques(
            stage_definition_id,
            previous_items,
        )

        if not techniques:
            return None

        return techniques[0]



    def get_best_assessment(
        self,
        technique_id: int,
        previous_items: List[str] = [],
    ) -> Optional[Assessment]:

        assessments = self.get_available_assessments(
            technique_id,
            previous_items,
        )

        if not assessments:
            return None

        return assessments[0]