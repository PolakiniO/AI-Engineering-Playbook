---
name: product-designer
description: Turn ideas, workflows, screenshots, or design briefs into credible product design direction and frontend guidance that avoids generic AI-looking UI.
metadata:
  short-description: Design specific, polished product experiences
---

# product-designer

## Purpose During Development

Use this skill when Codex and similar AI coding agents need to turn an idea, feature, workflow, screenshot, or design brief into a credible product design that feels specific, polished, and appropriate to the domain.

This is a reusable development-time reasoning framework. It is not runtime code and must not be coupled into the product being designed.

## When To Apply

- new product, feature, dashboard, landing page, tool, game, or app design work
- frontend implementation where visual quality, information architecture, or interaction design matters
- redesigns that need to stop looking generic, template-like, or AI-generated
- translating rough ideas, sketches, screenshots, or brand cues into buildable UI direction

## What To Inspect

- existing product UI, screenshots, design system, components, brand assets, typography, and color usage
- target users, primary workflows, domain expectations, and density needs
- competitor or reference products when provided by the user
- accessibility, responsive layout, empty states, loading states, error states, and edge cases
- implementation constraints in the frontend stack and component library

## Rules To Enforce

- design the actual first-use experience, not a marketing wrapper around it
- make the design specific to the product domain, user workflow, and data shape
- prefer realistic content, proportions, spacing, and states over decorative filler
- use established components and icon libraries already present in the project
- avoid generic AI visual tropes such as vague gradient panels, unrelated decorative shapes, fake SaaS cards, and placeholder-only layouts
- verify that text, controls, and visual hierarchy work on mobile and desktop
- keep visual ambition feasible for the implementation stack and timeline

## Design Quality Checklist

- define the primary user job and make it visible in the first screen
- choose layout density that matches actual use: focused for tools, expressive for games, editorial only when content warrants it
- include real navigation, actions, state transitions, and feedback
- make visual assets reveal the product, person, place, data, or gameplay rather than generic atmosphere
- ensure every color, icon, image, and typographic choice serves a recognizable product purpose
- inspect the final UI with screenshots or rendered output when available

## Common Anti-Patterns To Catch

- oversized hero sections for operational tools
- generic purple-blue gradients, floating blobs, and decorative cards with no workflow value
- placeholder data that hides real layout pressure
- designs that only look good at one viewport size
- UI copy that explains the interface instead of letting controls and states do the work
- adding polish that makes implementation brittle or inaccessible

## Expected Output From The Agent

- product design direction
- information architecture
- primary screen and flow decisions
- visual style guidance
- responsive and accessibility notes
- implementation-ready UI requirements
- visual QA plan

## Output Structure

- Summary
- Key Findings
- Risks
- Affected Files
- Affected Areas
- Design Direction
- Interaction Model
- Visual Quality Bar
- Suggested Improvements
- Suggested Tests
- Skills applied

## Example Usage

"Use this skill to redesign this dashboard so it feels like a real operations tool instead of a generic AI layout."

"Turn this rough app idea into an implementation-ready product design."
