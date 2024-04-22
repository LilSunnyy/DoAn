import Container from "@mui/material/Container";
import PauseIcon from '@mui/icons-material/Pause';
import Image from 'next/image'
import { Box, Button, Grid } from "@mui/material";
import FlagIcon from '@mui/icons-material/Flag';

interface IProps {
    course: ITrack;
}

const MainContentCourse = (props: IProps) => {
    return (
        <div style={{ marginTop: 20 }}>
            <div
                style={{
                    padding: 20,
                    height: 400,
                    background: "linear-gradient(135deg, rgb(106, 112, 67) 0%, rgb(11, 15, 20) 100%)"
                }}
            >
                <Container sx={{ display: "flex", gap: 15, height: "100%" }}>
                    <Box>
                        <Grid container
                            spacing={2}
                            sx={{
                                display: "flex",
                                alignItems: "center",
                            }}>
                            <Grid>

                            </Grid>
                        </Grid>
                    </Box>
                </Container>
            </div>
        </div>
    )
}

export default MainContentCourse;