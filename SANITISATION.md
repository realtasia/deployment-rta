# deployment-rta sanitisation record

This is modern editorial material for the 2026 realTasia archive.

## Publication model

The public repository is a single sanitised snapshot commit. It contains no reachable historical Git objects. The complete original history remains only in the untouched private `pipewrk/deployment-rta` archival master.

Private transformation records connect the source history to this snapshot. They remain outside the public repository because publishing them could expose identifiers for private commits.

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

`COMMIT_COMMENTARY.md` is contemporary analysis. Its historical commit identifiers are archival citations into the sealed private master, not links to public Git objects.

## Rights

No open-source licence is granted for this repository as a whole. Historical third-party notices continue to govern the files they cover. All other rights are reserved.
