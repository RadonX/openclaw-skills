# Filtering rules

The exported transcript is a *view*.

Keep:
- role=user: text
- role=assistant: text blocks only

Drop (from export only):
- role=toolResult (all)
- assistant content blocks: toolCall
- assistant content blocks: thinking (if present)

Never drop:
- user messages, even if they contain `/commands` text
