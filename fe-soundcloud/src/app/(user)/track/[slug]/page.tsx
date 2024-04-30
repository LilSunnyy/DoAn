
import { CardMedia, Container, Grid } from "@mui/material";
import { getIdFromUrl, sendRequest } from '@/utils/api';
import Divider from '@mui/material/Divider';
import { Box } from "@mui/material";
import WaveTrack from "@/components/track/wave.track";


const DetailTrackPage = async ({ params }: { params: { slug: string } }) => {
    const id = getIdFromUrl(params.slug)
    return (
        <Container>
            <WaveTrack id={id} />
        </Container>
    )
}

export default DetailTrackPage;