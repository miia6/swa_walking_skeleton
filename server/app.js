import { Hono } from "@hono/hono";
import { cors } from "@hono/hono/cors";
import { logger } from "@hono/hono/logger";
import postgres from "postgres";
//import { Redis } from "ioredis";

const app = new Hono();
const sql = postgres();
//const redis = new Redis(6379, "redis");

app.use("/*", cors());
app.use("/*", logger());

/*app.get("/redis-test", async (c) => {
    let count = await redis.get("test");
    if (!count) {
      count = 0;
    } else {
      count = Number(count);
    }
  
    count++;
  
    await redis.set("test", count);
    return c.json({ count });
});*/

app.get("/", (c) => c.json({ message: "Hello world!" }));
app.get("/todos", async (c) => {
    const todos = await sql`SELECT * FROM todos`;
    return c.json(todos);
});

export default app;