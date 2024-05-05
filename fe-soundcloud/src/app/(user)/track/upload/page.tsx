import UploadTabs from "@/components/track/upload.tabs";
import { Container } from "@mui/material";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";
import { redirect } from "next/navigation"
import { sendRequest } from "@/utils/api";

const UploadPage = async () => {
    const session = await getServerSession(authOptions)
    if (!session) {
        redirect("/")
    }

    const res = await sendRequest<IBackendRes<IGenre[]>>({
        url: "http://localhost:8000/genre/",
        method: "GET",
    })
    return (
        <Container>
            <UploadTabs
                genres={res.results ?? []}
            />
        </Container>
    )
}

export default UploadPage;