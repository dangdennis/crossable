import { NowRequest, NowResponse } from "@vercel/node";

export default function (req, res) {
  const { name = "World" } = req.query;
  res.send(`Hello ${name}!`);
}
