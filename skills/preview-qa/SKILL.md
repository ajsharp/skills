---
name: preview-qa
description: Plan and run focused QA on a deployed preview or staging web app, especially registration, email sign-in, and cross-browser recovery. Use when the user asks to test a preview deployment or prepare its QA plan. Do not use for routine unit tests or a production launch.
---

# Preview QA

Test the deployed change through the renter-facing flow and any expected email. A page loading alone does not prove the action completed.

## Set the boundary

1. Confirm the target PR, deployed commit, preview URL, issue requirements, and exact scenarios. If the user asks only for a plan, write the plan and stop before creating accounts or sending email.
2. Identify any controlled inbox, test account, allowed external delivery, and provider calls. Existing authorization in the conversation applies; do not infer permission to message other people, contact real properties, spend on providers, or reset shared data.
3. Choose one normal path and the few failure or recovery paths most likely to change the result. Record the expected route, visible state, and email for each.

## Run and verify

- Use a named, isolated browser session. Load the current browser tool instructions before using a CLI whose version may have changed. Take a fresh snapshot and check the URL after navigation; transitions can be brief.
- For protected Vercel previews or email sign-in, read [Vercel and AgentMail field notes](references/vercel-agentmail.md) before starting. Verify the current project, scope, deployment, and CLI versions instead of reusing an old URL or credential.
- Use a controlled inbox. Fetch the complete email before extracting a magic link; inbox lists may contain only metadata. Treat the link and all access tokens as secrets.
- For a browser-session recovery test, open the sign-in link in a second browser session with empty cookies and local storage. Revisit the application callback to check repeat handling; do not reuse a single-use magic link.
- Check the rendered UI at the requested viewport and theme. Verify saved behavior by returning to the app, signing in again, or using another browser session. Query the Preview database only when the user asks for it or a specific result cannot be established through the app and email.
- Keep screenshots, scripts, logs, and local results in ignored tmp/ or output/, or outside the repository. Do not commit temporary QA artifacts. Do not put contact details, private answers, auth links, or tokens in screenshots, logs, or reports.

## Report the result

State the deployed commit and tested paths. Separate passed, failed, and untested cases, with the exact visible behavior and email result. Include database findings only if queried. Name any real access or provider blocker. Say whether synthetic records remain. Close browser sessions you created; do not delete shared Preview records without authorization.
