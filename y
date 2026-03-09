{
  "indexes": [
    {
      "collectionGroup": "favorites",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "is_deleted_by_user",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "created_at",
          "order": "DESCENDING"
        },
        {
          "fieldPath": "__name__",
          "order": "DESCENDING"
        }
      ],
      "density": "SPARSE_ALL"
    },
    {
      "collectionGroup": "favorites",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "user_id",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "created_at",
          "order": "DESCENDING"
        },
        {
          "fieldPath": "__name__",
          "order": "DESCENDING"
        }
      ],
      "density": "SPARSE_ALL"
    },
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "user_ref",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "created_time",
          "order": "DESCENDING"
        },
        {
          "fieldPath": "__name__",
          "order": "DESCENDING"
        }
      ],
      "density": "SPARSE_ALL"
    },
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "user_ref",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "is_read",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "created_time",
          "order": "DESCENDING"
        },
        {
          "fieldPath": "__name__",
          "order": "DESCENDING"
        }
      ],
      "density": "SPARSE_ALL"
    },
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        {
          "fieldPath": "userId",
          "order": "ASCENDING"
        },
        {
          "fieldPath": "createdAt",
          "order": "DESCENDING"
        },
        {
          "fieldPath": "__name__",
          "order": "DESCENDING"
        }
      ],
      "density": "SPARSE_ALL"
    }
  ],
  "fieldOverrides": [
    {
      "collectionGroup": "fcm_tokens",
      "fieldPath": "fcm_token",
      "ttl": false,
      "indexes": [
        {
          "order": "ASCENDING",
          "queryScope": "COLLECTION_GROUP"
        }
      ]
    }
  ]
}