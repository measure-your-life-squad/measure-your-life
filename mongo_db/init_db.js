db.users.insert(
    {
        public_id: "4f175f70-d192-42a4-bd74-6f5b5baf7963",
        username: "admin",
        password: "pbkdf2:sha256:150000$PSdG6kjb$2c66a914379eb036292773c08c8ffac2bd3d794745d472169f5f27d0d7345d37",
        admin: "true",
        email: "admin@myl.com",
        email_confirmed: "true"
    }
);
db.users.insert(
    {
        public_id: "a42901cf-14df-4a15-acda-37c8a009ae9c",
        username: "dummyuser",
        password: "pbkdf2:sha256:150000$8MImQdIF$e95fc203a859d192eb6c2e3bf0bbc3f7e4f573b50462ce90bdb930036729a71c",
        admin: "false",
        email: "dummyuser@myl.com",
        email_confirmed: "true"
    }
);
db.categories.insert(
    {
        public_id: 1,
        name: "work",
        icon_name: "business"
    }
);
db.categories.insert(
    {
        public_id: 2,
        name: "duties",
        icon_name: "content_paste"
    }
);
db.categories.insert(
    {
        public_id: 3,
        name: "leisure",
        icon_name: "event_available"
    }
);