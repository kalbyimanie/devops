db.createUser(
    {
        user: "tiket",
        pwd: "tiket",
        roles:[
            {
                role: "dbAdmin",
                db: "admin"
            }
        ]
    }
);