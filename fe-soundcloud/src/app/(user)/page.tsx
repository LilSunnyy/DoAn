import MainSlider from "@/components/main/main.slider";
import { sendRequest } from "@/utils/api";
import { Container } from "@mui/material";
import { getServerSession } from "next-auth/next";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";

export default async function HomePage() {
  const session = await getServerSession(authOptions);

  const res = await fetch("http://127.0.0.1:8000/tracks/top/", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      genre: "love"
    })
  })

  console.log(await res.json());

  return (
    <Container>
      {/* <MainSlider
        results={res?.results ?? []}
      /> */}
    </Container>
  );
}
