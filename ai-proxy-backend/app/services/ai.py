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

import json
from typing import Any, Optional

from openai import AsyncOpenAI

from app.core.config import settings


class AIService:
    """
    Wrapper around the AI provider.

    The rest of the application should not know
    which LLM provider is being used.
    """

    def __init__(self):
        self.client = AsyncOpenAI(
            api_key=settings.AI_API_KEY
        )

        self.model = settings.MODEL


    async def generate(
        self,
        prompt: str,
        json_mode: bool = False,
    ) -> str | dict[str, Any]:
        """
        Generate content from the LLM.

        Args:
            prompt:
                Final prepared prompt.

            json_mode:
                Whether the response should be parsed as JSON.
        """

        try:

            response = await self.client.chat.completions.create(

                model=self.model,

                messages=[
                    {
                        "role": "system",
                        "content": (
                            "You are a helpful AI "
                            "learning assistant."
                        ),
                    },
                    {
                        "role": "user",
                        "content": prompt,
                    },
                ],

                temperature=0.7,

                response_format=(
                    {
                        "type": "json_object"
                    }
                    if json_mode
                    else None
                ),
            )


            content = (
                response
                .choices[0]
                .message
                .content
            )


            if content is None:
                raise RuntimeError(
                    "AI returned empty response"
                )


            if json_mode:
                return json.loads(content)


            return content


        except Exception as error:

            raise RuntimeError(
                f"AI generation failed: {str(error)}"
            )



# Singleton instance
ai_service = AIService()