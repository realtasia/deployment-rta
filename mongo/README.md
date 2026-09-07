# Sanitised MongoDB archive support

This directory preserves the non-personal MongoDB material needed to understand and bootstrap the historical application without publishing the original database dump.

## Contents

- `pages.bson`: 6,994 sanitised company, library and location documents, preserving original identifiers and taxonomy relationships.
- `singpost.bson.gz`: 265,678 sanitised address-reference documents used by location and listing search.
- `bootstrap.js`: a synthetic OAuth client, a synthetic archive owner and 34 deduplicated historical indexes.
- `SCHEMA.md`: the collection-level structural audit and publication disposition.
- `verification.json`: mechanical transformation counts for `pages.bson`.

## Restore

These commands are documentary examples for MongoDB Database Tools and `mongosh`. They do not make the historical PHP stack compatible with a current runtime.

```sh
mongorestore --db archive_realtasia --collection pages mongo/pages.bson
mongorestore --gzip --db archive_realtasia --collection singpost mongo/singpost.bson.gz
mongosh mongodb://localhost/archive_realtasia mongo/bootstrap.js
```

The synthetic OAuth client matches the sanitised `RT::CLIENT_ID` and `RT::CLIENT_REDIRECT` values in `common-rta`. It contains no historical client secret.

## Pages transformation

The snapshot preserves every page document, `_id`, classification, name, slug, URI, keyword, location parent, sector and property classification. It makes these privacy transformations:

- every embedded page owner becomes the single synthetic `Archive Owner` identity;
- member, subscriber and liker arrays are emptied;
- attachment arrays are emptied;
- aggregate count shapes remain, with numeric values reset to zero.

The source collection contained no email address, phone-like value or external URL in page names, content or attachments. Two non-empty content fields were retained after that structural check.

## SingPost transformation

All 265,678 address-reference documents, identifiers, address fields, postcodes, geospatial values, keywords, property classifications and page relationships are retained. The transformation replaces 22,492 operational `source` values and 1,624 free-text `comments` values with explicit archive markers. No email address, phone-like value, external URL or MongoDB URI remains in the transformed dataset.

The historical provenance and reuse position of the address dataset remain documented caveats. Its inclusion preserves application behaviour and does not grant a licence to reuse the data.
