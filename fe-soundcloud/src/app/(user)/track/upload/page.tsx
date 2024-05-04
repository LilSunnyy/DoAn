import UploadTabs from "@/components/track/upload.tabs";
import { Container } from "@mui/material";
import { getServerSession } from "next-auth";
import { authOptions } from "@/app/api/auth/[...nextauth]/route";
import { redirect } from "next/navigation"

const UploadPage = async () => {
    const session = await getServerSession(authOptions)
    if (!session) {
        redirect("/")
    }
    return (
        <Container>
            <UploadTabs />
        </Container>
    )
}

export default UploadPage;