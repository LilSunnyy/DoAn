'use client'
import { useHasMounted } from "@/utils/customHook";
import { Container } from "@mui/material";
import AppBar from "@mui/material/AppBar";
import AudioPlayer from 'react-h5-audio-player';
import 'react-h5-audio-player/lib/styles.css';

const AppFooter = () => {
    const hasMounted = useHasMounted();
    if (!hasMounted) return (<></>)

    return (
        <AppBar
            position="fixed"
            sx={{
                top: 'auto', bottom: 0, background: "#f2f2f2"
            }}>
            <Container sx={{ display: "flex", gap: 10 }}>
                <AudioPlayer
                    autoPlay={false}
                    src="http://localhost:8000/static/song/2024/03/Sau_C%C6%A1n_M%C6%B0a_-_CoolKid_ft_Rhyder.mp3"
                    onPlay={() => { }}
                    style={{
                        boxShadow: "unset",
                        background: "#f2f2f2"
                    }}
                />
                <div style={{
                    display: "flex",
                    flexDirection: "column",
                    alignItems: "start",
                    justifyContent: "center",
                    minWidth: 100
                }}>
                    <div style={{ color: "#ccc" }}>Dat</div>
                    <div style={{ color: "black" }}>yeah</div>
                </div>
            </Container>
        </AppBar>
    )
}

export default AppFooter;