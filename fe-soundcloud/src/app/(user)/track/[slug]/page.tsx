
import { CardMedia, Container, Grid } from "@mui/material";
import { getIdFromUrl, sendRequest } from '@/utils/api';
import Divider from '@mui/material/Divider';
import { Box } from "@mui/material";
import WaveTrackHeader from "@/components/track/wave.track";


const DetailTrackPage = async ({ params }: { params: { slug: string } }) => {
    const id = getIdFromUrl(params.slug)
    const res = await sendRequest<IBackendRes<ITrack>>({
        url: `http://localhost:8000/tracks/${id}/`,
        method: "GET",
    })

    return (
        <Container>
            {res.results && (<WaveTrackHeader id={id} track={res.results} />)}
        </Container>
    )
}

export default DetailTrackPage;