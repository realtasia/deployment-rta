# MongoDB structural audit

The private deployment dump was inspected without publishing record values. MongoDB is schemaless, so this records observed collection shapes, document counts and the publication decision for each collection.

| Collection | Documents | Observed role | Public treatment |
| --- | ---: | --- | --- |
| `agents` | 35,398 | Agent directory with names, email addresses, mobile numbers and professional identifiers | Excluded as personal data |
| `comments` | 6 | User-authored messages with access tokens and user references | Excluded as private communication and authentication data |
| `interactions` | 58 | User-to-object interaction records | Excluded as behavioural data |
| `jobs` | 438 | Background delivery jobs and message payloads | Excluded as operational data |
| `oauth2_clients` | 2 | OAuth client bootstrap records containing secrets | Replaced by one synthetic client matching the public configuration |
| `oauth2_sessions` | 0 | OAuth session collection | No records to preserve; collection indexes retained |
| `pages` | 6,994 | 2,938 companies, 4 libraries and 4,052 locations | Published as sanitised `pages.bson` |
| `posts` | 96 | User-authored posts, messages and relationship references | Excluded as communication and behavioural data |
| `singpost` | 265,678 | Address and property-location reference dataset used by location and listing search | Published as sanitised, compressed `singpost.bson.gz`; source and free-text comment values replaced |
| `system.indexes` | 88 | Historical index metadata, including duplicate entries | Converted into 34 unique executable index definitions |
| `ticker` | 32 | Per-user feed materialisation | Excluded as behavioural data |
| `users` | 4 | Profiles, contact details, passwords, access tokens and session values | Replaced only by a locked synthetic archive owner |

## Published `pages` fields

The sanitised collection retains the observed first-level shape: `_id`, `attachments`, `content`, `counts`, `created`, `keywords`, `license`, `likers`, `members`, `modified`, `name`, `oldestate`, `parent`, `privacy`, `property_type`, `sector`, `sectors`, `slug`, `stats`, `status`, `subscribers`, `subtype`, `type`, `uri` and `user`.

Observed page classifications are retained:

| Type or subtype | Documents |
| --- | ---: |
| Company | 2,938 |
| Library | 4 |
| Location | 4,052 |
| Agency | 2,936 |
| Commercial | 2 |
| Estate | 116 |
| HDB | 192 |
| Private Apartments | 3,706 |
| Serviced Apartments | 38 |

The remaining four records carried an empty subtype.

## Published `singpost` fields

The sanitised collection retains `_id`, `address`, `building`, `child`, `comments`, `estate`, `geo`, `geo_accuracy`, `keywords`, `locality`, `modified`, `number`, `other_name`, `postal`, `property_type`, `source`, `street` and `type` wherever present in the source document.

All 265,678 identifiers and top-level document shapes are preserved. Operational source values and free-text comments are replaced with fixed archive markers; address, postcode, geospatial, classification and relationship data remain intact.
