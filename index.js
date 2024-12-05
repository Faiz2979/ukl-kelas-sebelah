const express = require("express");
require("dotenv").config();

const app = express();

const inventory = require("./routes/inventory");
const user = require("./routes/user");
const auth = require("./routes/auth");

app.use(express.json());
app.use("/inventory", inventory);
app.use("/users", user);
app.use("/auth", auth);

app.get("/", (request, response) => {
  response.json({ welcome: "hello prisma." });
});

const PORT = process.env.PORT || 3030;
app.listen(PORT, () => {
  console.log(`server started on port ${PORT}`);
});
