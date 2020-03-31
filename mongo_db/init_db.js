db.users.insert(
    {
        public_id: "4f175f70-d192-42a4-bd74-6f5b5baf7963",
        name: "admin",
        password: "pbkdf2:sha256:150000$PSdG6kjb$2c66a914379eb036292773c08c8ffac2bd3d794745d472169f5f27d0d7345d37",
        admin: "True"
    }
);
db.users.insert(
    {
        public_id: "a42901cf-14df-4a15-acda-37c8a009ae9c",
        name: "dummyuser",
        password: "pbkdf2:sha256:150000$8MImQdIF$e95fc203a859d192eb6c2e3bf0bbc3f7e4f573b50462ce90bdb930036729a71c",
        admin: "False"
    }
);
db.categories.insert(
    {
        public_id: 1,
        name: "work",
        icon_name: "work_icon"
    }
);
db.categories.insert(
    {
        public_id: 2,
        name: "responsibilities",
        icon_name: "responsibilities_icon"
    }
);
db.categories.insert(
    {
        public_id: 3,
        name: "leisure",
        icon_name: "leisure_icon"
    }
);