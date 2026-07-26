"""
app/services/ai.py

This file is the only place that knows about the LLM provider.

Responsibilities:

Hide API key usage.
Hide model selection.
Provide a simple interface for the rest of the application.
Handle common AI failures.
Support JSON responses because your syllabus and assessment endpoints need structured output.

The rest of your backend should only call:

await ai.generate(prompt)

and never import the LLM SDK directly.
"""
from app.core.config import settings


import json
from typing import Any

from google import genai
from google.genai import types

from app.core.config import settings


class AIService:
    """
    Wrapper around the AI provider.

    The rest of the application should not know
    which LLM provider is being used.
    """

    def __init__(self):
        self.client = genai.Client(
            api_key=settings.AI_API_KEY
        )

        self.model = settings.MODEL

    async def generate(
        self,
        prompt: str,
        json_mode: bool = False,
    ) -> str | dict[str, Any]:
        try:
            config = types.GenerateContentConfig(
                temperature=0.7,
                system_instruction="You are a helpful AI learning assistant.",
            )

            if json_mode:
                config.response_mime_type = "application/json"

            response = await self.client.aio.models.generate_content(
                model=self.model,
                contents=prompt,
                config=config,
            )

            content = response.text

            if not content:
                raise RuntimeError("AI returned empty response")

            if json_mode:
                return json.loads(content)

            return content

        except Exception as error:
            raise RuntimeError(
                f"AI generation failed: {error}"
            )



# Singleton instance
ai_service = AIService()