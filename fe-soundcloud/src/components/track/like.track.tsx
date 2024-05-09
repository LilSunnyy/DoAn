'use client'
import Chip from '@mui/material/Chip';
import FavoriteIcon from '@mui/icons-material/Favorite';
import PlayArrowIcon from '@mui/icons-material/PlayArrow';
import { useEffect, useState } from 'react';
import { sendRequest } from '@/utils/api';
import { useSession } from "next-auth/react";
import { useRouter } from "next/navigation";


interface IProps {
    track: ITrack | null;
}
const LikeTrack = (props: IProps) => {
    const { track } = props;
    const { data: session } = useSession();
    const router = useRouter();

    const [trackLikes, setTrackLikes] = useState<ITrack[] | null>(null);

    const fetchData = async () => {
        if (session?.access_token) {
            const res2 = await sendRequest<IBackendRes<ILike>>({
                url: `http://localhost:8000/like/`,
                method: "GET",
                queryParams: {
                    current: 1,
                    pageSize: 100,
                    sort: "-createdAt"
                },
                headers: {
                    Authorization: `Bearer ${session?.access_token}`,
                },
            })
            if (res2?.results)
                setTrackLikes(res2?.results)
        }
    }
    useEffect(() => {
        fetchData();
    }, [session])

    const handleLikeTrack = async () => {
        await sendRequest<IBackendRes<ITrack>>({
            url: `http://localhost:8000/api/v1/likes`,
            method: "POST",
            body: {
                track: track?.id,
                quantity: trackLikes?.some(t => t.id === track?.id) ? -1 : 1,
            },
            headers: {
                Authorization: `Bearer ${session?.access_token}`,
            },
        })

        fetchData();
        router.refresh();

    }
    return (
        <div style={{ marginTop: "20px", display: "flex", justifyContent: "space-between", width: "100%" }}>
            <Chip
                onClick={() => handleLikeTrack()}
                sx={{ borderRadius: "5px" }}
                size="medium"
                variant="outlined"
                color={trackLikes?.some(t => t.id === track?.id) ? "error" : "default"}
                clickable
                icon={<FavoriteIcon />} label="Like"
            />
            <div style={{ display: "flex", gap: "20px", color: "#999" }}>
                <span style={{ display: "flex", alignItems: "center" }}><PlayArrowIcon sx={{ fontSize: "20px" }} /> {track?.view}</span>
                <span style={{ display: "flex", alignItems: "center" }}><FavoriteIcon sx={{ fontSize: "20px" }} /> {track?.like}</span>
            </div>
        </div>
    )
}

export default LikeTrack;