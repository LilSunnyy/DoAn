'use client'
import { Box, Grid } from "@mui/material";
import DoneIcon from '@mui/icons-material/Done';

const data = [
    "Tập làm quen với các bài nghe đa dạng chủ đề",
    "Từ vựng phong phú qua những bài kiểm tra",
    "Khả năng đọc hiểu tiếng Anh",
    "Thông hiểu cấu trúc đề thi thật",
    "Phát âm chuẩn hóa theo người bản địa",
    "Tăng độ tự tin khi làm bài thi thật"
]

const ThingsLearn = () => {
    return (
        <>
            <Box sx={{ border: 1, borderColor: "#d1d7dc", padding: "1rem", marginTop: "2rem" }}>
                <h2 style={{ marginTop: 0, marginBottom: "1rem" }}>Những gì bạn đạt được</h2>
                <Grid container
                    spacing={2}
                    sx={{
                        display: "flex",
                        alignItems: "center",
                    }}
                >
                    {data.map(data => (
                        <Grid
                            item
                            xs={12}
                            sm={12}
                            md={6}
                            lg={6}
                        >
                            <div style={{ display: "flex", alignItems: "center" }}>
                                <DoneIcon />
                                <span>{data}</span>
                            </div>
                        </Grid>
                    ))}

                </Grid>
            </Box>
        </>
    )
}

export default ThingsLearn;