
import { CardMedia, Container, Grid } from "@mui/material";
import { getIdFromUrl, sendRequest } from '@/utils/api';
import Divider from '@mui/material/Divider';
import { Box } from "@mui/material";
import WaveTrack from "@/components/track/wave.track";


const DetailTrackPage = async ({ params }: { params: { slug: string } }) => {
    const id = getIdFromUrl(params.slug)
    const res = await sendRequest<IBackendRes<ITrack>>({
        url: `http://localhost:8000/tracks/${id}/`,
        method: "GET",
    })

    const resComments = await sendRequest<IBackendRes<IComment[]>>({
        url: `http://localhost:8000/comment/${id}/track-comments/`,
        method: "GET",
    })

    return (
        <Container>
            {res.results && (
                <WaveTrack
                    id={id}
                    track={res.results}
                    comments={resComments.results?.reverse() ?? []} />
            )}
        </Container>
    )
}

export default DetailTrackPage;