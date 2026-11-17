// Modern, sanitised bootstrap for the historical realTasia MongoDB shape.
// Run with: mongosh mongodb://localhost/archive_realtasia mongo/bootstrap.js

var archiveDb = db.getSiblingDB('archive_realtasia');
var archiveOwnerId = ObjectId('000000000000000000000001');

archiveDb.oauth2_clients.updateOne(
  { client_id: '123456789' },
  { $set: {
    name: 'realTasia archival client',
    client_id: '123456789',
    client_secret: 'archive-client-secret',
    redirect_uri: 'http://realtasia.com.sg',
    status: 'active',
    auto_approve: true
  } },
  { upsert: true }
);

archiveDb.users.updateOne(
  { _id: archiveOwnerId },
  { $setOnInsert: {
    name: 'Archive Owner',
    username: 'archive-owner',
    email: 'archive-owner@example.invalid',
    active: false,
    status: 'archive',
    roles: []
  } },
  { upsert: true }
);

archiveDb.oauth2_clients.createIndex({ client_id: 1 }, { name: 'client_id_1', unique: true });
archiveDb.getCollection("singpost").createIndex({"estate":1,"child":1,"keywords":1}, {"name":"estate_1_child_1_keywords_1"});
archiveDb.getCollection("agents").createIndex({"email":1}, {"name":"email_1"});
archiveDb.getCollection("agents").createIndex({"mobile":1}, {"name":"mobile_1"});
archiveDb.getCollection("pages").createIndex({"name":1}, {"name":"name_1"});
archiveDb.getCollection("pages").createIndex({"status":1,"privacy.is":1,"modified":-1}, {"name":"status_privacy_modified"});
archiveDb.getCollection("pages").createIndex({"parent._id":1}, {"name":"parent_id","sparse":true});
archiveDb.getCollection("pages").createIndex({"keywords":1}, {"name":"page_keyword"});
archiveDb.getCollection("pages").createIndex({"type":1,"subtype":1}, {"name":"page_types"});
archiveDb.getCollection("pages").createIndex({"license":1}, {"name":"license_1"});
archiveDb.getCollection("users").createIndex({"keywords":1}, {"name":"user_keywords"});
archiveDb.getCollection("users").createIndex({"status":1,"roles":1,"settings.privacy.is":1,"active":-1}, {"name":"user_search_fields"});
archiveDb.getCollection("interactions").createIndex({"interaction":1}, {"name":"interaction_1"});
archiveDb.getCollection("interactions").createIndex({"object_id":1}, {"name":"object_id_1"});
archiveDb.getCollection("interactions").createIndex({"user._id":1}, {"name":"user__id_1"});
archiveDb.getCollection("comments").createIndex({"type":1,"status":1,"modified":-1}, {"name":"type_1_status_1_modified_-1"});
archiveDb.getCollection("comments").createIndex({"user._id":1}, {"name":"user__id_1"});
archiveDb.getCollection("comments").createIndex({"post._id":1,"post.type":1}, {"name":"post__id_1_post_type_1"});
archiveDb.getCollection("ticker").createIndex({"user_id":1}, {"name":"user_id_1"});
archiveDb.getCollection("ticker").createIndex({"document_id":1}, {"name":"document_id_1"});
archiveDb.getCollection("ticker").createIndex({"owner_id":1}, {"name":"owner_id_1"});
archiveDb.getCollection("ticker").createIndex({"visibility":1}, {"name":"visibility_1"});
archiveDb.getCollection("jobs").createIndex({"in_progress":1,"delivery":1,"status":1}, {"name":"in_progress_1_delivery_1_status_1"});
archiveDb.getCollection("jobs").createIndex({"document_id":1}, {"name":"document_id_1"});
archiveDb.getCollection("posts").createIndex({"status":1,"user._id":1,"privacy.is":1,"modified":1}, {"name":"post_id_fields"});
archiveDb.getCollection("posts").createIndex({"keywords":1}, {"name":"keywords_1"});
archiveDb.getCollection("posts").createIndex({"page_parent._id":1}, {"name":"page_parent__id_1"});
archiveDb.getCollection("posts").createIndex({"company._id":1}, {"name":"company__id_1"});
archiveDb.getCollection("posts").createIndex({"page._id":1}, {"name":"page__id_1"});
archiveDb.getCollection("posts").createIndex({"page.subtype":1}, {"name":"page_subtype_1"});
archiveDb.getCollection("posts").createIndex({"to._id":1}, {"name":"to__id_1"});
archiveDb.getCollection("posts").createIndex({"type":1}, {"name":"type_1"});
archiveDb.getCollection("posts").createIndex({"listing.unit":1}, {"name":"listing_unit_1"});
archiveDb.getCollection("posts").createIndex({"listing.type":1,"listing.price":1,"listing.rooms":1,"listing.built_size":1,"listing.leaseSpace":1}, {"name":"listing_type_1_listing_price_1_listing_rooms_1_listing_built_size_1_listing_leaseSpace_1"});
