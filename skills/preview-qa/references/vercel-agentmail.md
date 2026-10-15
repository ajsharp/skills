# Vercel and AgentMail field notes

These are operational lessons from a Rent Jesse Preview QA run on October 14, 2026. Recheck versions, project names, scopes, environment variables, and provider instructions on each run. They may change.

## Protected Vercel preview

- The globally installed agent-browser 0.39.1 lacked its skills command. An ephemeral current CLI worked:

      npm exec --yes --package=agent-browser@latest -- agent-browser skills get core --full
      npm exec --yes --package=agent-browser@latest -- agent-browser skills get protected-vercel-deployments --full

- Read the current protected-deployments guide before opening a protected preview. The preview may redirect to Vercel SSO even when the app itself is healthy. Use the existing authenticated Vercel account, correct project and scope, a short-lived development OIDC token, and the x-vercel-trusted-oidc-idp-token request header in the isolated browser session. Do not disable Deployment Protection to work around this.
- The globally installed Vercel CLI 50.9.6 was too old for the token command. The guide warns that versions 50.25.0 through 53.2.x print the token to stderr. Use a supported current CLI, such as an ephemeral vercel@latest, and verify its version first. Never print, record, or paste the token into a report.
- Check that the deployed commit matches the intended PR head. A remembered Preview URL may point to another deployment.

## Preview database, only when needed

Routine QA should use the app and expected email. Query the database only when the user asks for it or a specific result cannot be established through those paths.

- In the Rent Jesse worktree, vercel env run loaded local .env.local after Preview variables. DATABASE_URL then pointed to a local db.localtest.me host, and the query failed. Run the read-only query from an isolated temporary directory, selecting Preview, the project, scope, and Git branch explicitly. Verify the resolved database host before querying; do not print the full URL.
- For that run, direct TCP access to Preview Neon failed. The existing @neondatabase/serverless HTTP client worked. Use the project's installed client from a temporary script rather than adding an application dependency for QA.
- If a query is needed, keep it narrow and read-only. Do not reset, delete, or modify shared Preview data as cleanup. Report synthetic records left behind.

## AgentMail and magic links

- During the October 14 run, the AgentMail API key was only in the main Rent Jesse checkout .envrc. It has since moved to the main checkout's ignored .env.local, which is linked into the worktree. CLI scripts must load that file explicitly; direnv no longer supplies the key. Check the documented project configuration narrowly without printing the key. Do not scan unrelated credential files, create a replacement inbox, or call agent.sign_up to recover access; sign-up can rotate an existing key.
- Inbox listing returns metadata. Fetch the full message to read the sign-in URL. The Python SDK was absent in that run and could be installed ephemerally without changing app dependencies.
- Confirm the controlled inbox for this run. A single inbox can test both a new account and an existing account after sign-out. A second controlled account is required to test a wrong-account sign-in; report that case untested if none is available.
- Sending a diagnostic email to someone else requires that person's explicit authorization for that message. An email provider accepting a message is distinct from verifying receipt.

## Browser and survey recovery

- Start a fresh browser session with empty cookies and local storage for cross-browser sign-in. The original session alone cannot prove recovery. Test the signed-out completion callback, its repeated visit, and an answer edit made while sign-in is pending. Compare the answers restored in the app with the final choices; a success screen can conceal stale saved data.
- A direct visit to a guarded loading route may redirect to the survey. Reach it through a valid survey draft. After contact details, a brief loading route can precede results. Wait for the expected URL or text rather than assuming the first snapshot is final; a progress stream may keep the network active.
- Revisit the app callback for an idempotency check. Do not reopen a consumed magic link.
