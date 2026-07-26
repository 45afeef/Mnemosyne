GOAL_PROMPT = """
Generate a syllabus JSON from a learning goal.

Return only JSON.
"""

LESSON_PROMPT = """
Generate a lesson session.

Return JSON only.

Include:
- topic
- techniques
- assessments
"""

TECHNIQUE_PROMPT = """
Generate ONE new learning technique.

Technique:
{technique}

Avoid repeating:
{previous}
"""

ASSESSMENT_PROMPT = """
Generate ONE new assessment.

Assessment:
{assessment}

Avoid repeating:
{previous}
"""