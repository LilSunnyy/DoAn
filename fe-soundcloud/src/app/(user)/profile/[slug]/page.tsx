import ProfileTracks from "@/components/header/profile.tracks";
import { sendRequest } from "@/utils/api";
import { Container, Grid } from "@mui/material";

const ProfilePage = async ({ params }: { params: { slug: string } }) => {
    const res = await sendRequest<IBackendRes<ITrack[]>>({
        url: "http://localhost:8000/tracks/user/?page=1",
        method: "post",
        body: { user_id: `${params.slug}` }
    })

    const data = res?.results ?? []

    return (
        <Container sx={{ my: 5 }}>
            <Grid container spacing={5}>
                {data.map((item: any, index: number) => {
                    return (
                        <Grid item xs={12} md={6} key={index}>
                            <ProfileTracks data={item} />
                        </Grid>
                    )
                })}
            </Grid>
        </Container>

    )
}

export default ProfilePage;