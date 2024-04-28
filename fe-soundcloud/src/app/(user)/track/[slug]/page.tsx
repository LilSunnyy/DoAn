
import { CardMedia, Container, Grid } from "@mui/material";
import { getIdFromUrl, sendRequest } from '@/utils/api';
import Divider from '@mui/material/Divider';
import { Box } from "@mui/material";
import WaveTrack from "@/components/track/wave.track";

const DetailTrackPage = async ({ params }: { params: { slug: string } }) => {
    console.log(getIdFromUrl(params.slug))
    return (
        <>
            <WaveTrack />
        </>
    )
}

export default DetailTrackPage;