# deployment-rta sanitisation record

This is modern editorial material for the 2026 realTasia archive.

## Publication model

The public repository preserves the master-branch commit sequence, messages, dates and authors. Identifying data and credential values in historical database records, and a private key, have been redacted; those changes produce new commit IDs. The untouched private `pipewrk/deployment-rta` archival master remains the source. The public commentary links to the rewritten commits.

GitHub continued to serve superseded commits by SHA after this rewrite. Removing those cached views requires separate GitHub cleanup.

## Historical data redactions

The captured agent collection retains all 35,398 records and their IDs. Agent names, mobile numbers, email addresses, personal licence references, individual image and profile links, and identifying contact text embedded in designations were redacted. Identifying names and contact details were also redacted where embedded in user, page, interaction, comment and post records. Three log entries had a personal account name removed from a file path; all 74,106 log records remain. The database collection counts and record IDs remain unchanged.

The following historical commits touched the affected database dumps. The first identifier is from the private source; the link opens its rewritten public counterpart. Subsequent commit IDs also change where their ancestry changes.

| Original commit | Public commit | Original message |
|---|---|---|
| `f297662` | [`1bf9048`](https://github.com/realtasia/deployment-rta/commit/1bf9048cf87bfef56112f9a1d27b366188d664f9) | Added ssh folder |
| `96c5d9d` | [`4073a9b`](https://github.com/realtasia/deployment-rta/commit/4073a9b3b3b6b01b38ab7f1adbcd01ef0f763e3f) | added mongo dump |

## Historical credential redactions

A historical SSH private key and credential values in the database dumps were replaced with explicit redaction markers throughout the public history. The database redactions cover access tokens, client secrets, passwords and tokens in user, comment and OAuth records; collection counts and record IDs remain. The surrounding files, commit sequence and commit metadata remain.

The following commits introduced or changed the affected material. The first identifier refers to the private source; the link opens the rewritten public commit. Later commit IDs may also differ because their ancestry changed.

| Original commit | Public commit | Original message |
|---|---|---|
| `96c5d9d` | [`4073a9b`](https://github.com/realtasia/deployment-rta/commit/4073a9b3b3b6b01b38ab7f1adbcd01ef0f763e3f) | added mongo dump |
| `f297662` | [`1bf9048`](https://github.com/realtasia/deployment-rta/commit/1bf9048cf87bfef56112f9a1d27b366188d664f9) | Added ssh folder |

Affected paths:

- `ssh/realtasiaWorker.pem`
- `mongoDump/db/db/comments.bson`
- `mongoDump/db/db/oauth2_clients.bson`
- `mongoDump/db/db/users.bson`
- `mongoDump/db-jul-23-2013/comments.bson`
- `mongoDump/db-jul-23-2013/oauth2_sessions.bson`
- `mongoDump/db-jul-23-2013/users.bson`

## Snapshot changes

| Category | Treatment | Reason | Behavioural effect |
|---|---|---|---|
| Raw MongoDB dumps | Replaced by sanitised `pages` and `singpost` collections, a synthetic bootstrap and value-free schema manifest | The original mixed required reference data with people, credentials, sessions, communications and operational records | Company, library, location and address-reference behaviour plus database shape are restorable; private runtime records remain excluded |
| Page ownership and relationship state | Embedded owners replaced by one synthetic archive identity; members, subscribers, likers and attachments emptied; counts zeroed | Preserve the complete page taxonomy without publishing identities or interactions | All 6,994 page records and their structural relationships remain; social state is intentionally empty |
| SingPost address-reference data | All records retained; operational source values and free-text comments replaced with fixed archive markers | Location and listing search depend on this collection, while source URLs and comments are unnecessary exposure | All 265,678 IDs, addresses, postcodes, geospatial values, classifications and relationships remain available |
| OAuth clients and users | Original records omitted; one matching synthetic OAuth client and one locked synthetic owner supplied | The application requires a registered client, but original secrets and profiles cannot be public | Client-credential bootstrap and page ownership references can resolve without historical identities |
| MongoDB indexes | 88 historical index records deduplicated into 34 executable definitions | Index structure is application architecture rather than private runtime data | Historical query shape can be recreated without publishing database contents |
| SSH directory | Omitted | It contained private-key and access material | The original SSH bootstrap path cannot operate |
| Historical deployment-bundle endpoint | Replaced with a deliberately non-resolving synthetic URL | The live bucket is private operational material | The original bootstrap download deliberately fails |

The provisioning and Nginx source is retained as historical architecture after manual review. It targets obsolete infrastructure and must not be executed as current deployment guidance.

`COMMIT_COMMENTARY.md` is contemporary analysis. Its links point to the corresponding rewritten public commits.

## Rights

No open-source licence is granted for this repository as a whole. Historical third-party notices continue to govern the files they cover. All other rights are reserved.
