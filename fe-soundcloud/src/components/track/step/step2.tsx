'use client'

import { Container } from "@mui/material";
import Tabs from '@mui/material/Tabs';
import Tab from '@mui/material/Tab';
import Typography from '@mui/material/Typography';
import Box from '@mui/material/Box';
import * as React from 'react';
import { useDropzone, FileWithPath } from 'react-dropzone';
import './dropzone.scss';
import { styled } from '@mui/material/styles';
import Button from '@mui/material/Button';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import LinearProgress, { LinearProgressProps } from '@mui/material/LinearProgress';
import Grid from '@mui/material/Grid';
import TextField from '@mui/material/TextField';
import MenuItem from '@mui/material/MenuItem';
import { useState } from "react";
import axios from 'axios';
import { useSession } from 'next-auth/react';
import Image from 'next/image'
import { sendRequest } from "@/utils/api";

function LinearProgressWithLabel(props: LinearProgressProps & { value: number }) {
    return (
        <Box sx={{ display: 'flex', alignItems: 'center' }}>
            <Box sx={{ width: '100%', mr: 1 }}>
                <LinearProgress variant="determinate" {...props} />
            </Box>
            <Box sx={{ minWidth: 35 }}>
                <Typography variant="body2" color="text.secondary">{`${Math.round(
                    props.value,
                )}%`}</Typography>
            </Box>
        </Box>
    );
}

function LinearWithValueLabel(trackUpload: {
    trackUpload: {
        fileName: string;
        percent: number;
        id: number;
    }
}) {

    return (
        <Box sx={{ width: '100%' }}>
            <LinearProgressWithLabel value={trackUpload.trackUpload.percent} />
        </Box>
    );
}

const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: 1,
    overflow: 'hidden',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: 1,
});

interface IProps {
    trackUpload: {
        fileName: string;
        percent: number;
        id: number;
    },
    genres: IGenre[]
}

interface INewTrack {
    fk_genre: string;
    description: string;
    photo: string;
    title: string;
    url: string;
}



const Step2 = (props: IProps) => {
    const { genres, trackUpload } = props;
    const [fileSelected, setFileSelected] = React.useState<File | null>(null)
    const { data: session } = useSession();
    const [infor, setInfor] = useState<INewTrack>({
        fk_genre: "",
        description: "",
        photo: "",
        title: "",
        url: ""
    })
    const [error, setError] = useState({
        title: {
            error: false,
            errorMessage: 'Tiêu đề không được bỏ trống'
        },
        description: {
            error: false,
            errorMessage: 'Mô tả không được để trống'
        },
        fk_genre: {
            error: false,
            errorMessage: 'Thể loại chưa được chọn'
        },
    })

    function InputFileUpload() {
        const onFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
            const event = e.target as HTMLInputElement;
            if (event.files) {
                const file = event.files[0];
                if (file.type.startsWith('image/')) {
                    const formData = new FormData();
                    setFileSelected(file);
                    formData.append("photo", file, file.name);
                    formData.append("id", trackUpload.id.toString())
                    if (trackUpload.id !== 0) {
                        handleFileUpload(formData);
                    } else {
                        alert("Việc tải âm thanh chưa hoàn thành")
                    }

                }
            }
        };

        return (
            <Button
                component="label"
                variant="contained"
                startIcon={<CloudUploadIcon />}
            >
                Upload file
                <input
                    type="file"
                    onChange={onFileChange}
                    style={{ display: "none" }}
                />
            </Button>
        );
    }

    const handleFileUpload = async (formData: FormData) => {
        try {
            const res = await axios.post('http://localhost:8000/tracks/', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                    'Authorization': `Bearer ${session?.access_token}`,
                },
            })
            setInfor({
                ...infor,
                photo: res.data.results.photo ?? ''
            })
        } catch (error) {
            //@ts-ignore
            alert(error?.response?.data)
        }
    }

    const handleSubmitForm = async () => {
        if (infor.title === '' || infor.description === '') {
            if (infor.fk_genre === '') {
                const newErrorState = {
                    ...error,
                    fk_genre: {
                        error: true,
                        errorMessage: error.fk_genre.errorMessage
                    }
                };
                setError(newErrorState);
            }
            return
        }
        const resPop = await sendRequest<IBackendRes<ITrack>>({
            url: "http://localhost:8000/tracks/",
            method: "POST",
            headers: {
                'Authorization': `Bearer ${session?.access_token}`,
            },
            body: {
                id: trackUpload.id,
                title: infor.title,
                description: infor.description,
                fk_genre: infor.fk_genre,
            }
        })
    }

    return (
        <div>
            <div>
                <div>
                    {props.trackUpload.fileName}
                </div>
                <LinearWithValueLabel
                    trackUpload={trackUpload}
                />
            </div>

            <Grid container spacing={2} mt={5}>
                <Grid item xs={6} md={4}
                    sx={{
                        display: "flex",
                        justifyContent: "center",
                        alignItems: "center",
                        flexDirection: "column",
                        gap: "10px"
                    }}
                >
                    <div style={{ height: 250, width: 250, background: "#ccc" }}>
                        {infor.photo && (
                            <Image
                                src={process.env.NEXT_PUBLIC_BACKEND_URL_IMAGE + (infor.photo).substring(1) || ""}
                                width={250}
                                height={250}
                                alt={infor.title}
                                quality={80}
                            />
                        )}

                    </div>
                    <div >
                        <InputFileUpload />
                    </div>

                </Grid>
                <Grid item xs={6} md={8}>
                    <TextField
                        label="Tiêu đề"
                        variant="standard"
                        required
                        fullWidth margin="dense"
                        value={infor?.title ?? props.trackUpload.fileName.split('.').slice(0, -1).join('.')}
                        error={error.title.error}
                        helperText={error.title.error ? error.title.errorMessage : ''}
                        onChange={(e) => {
                            const descriptionValue = e.target.value.trim();
                            const newErrorState = {
                                ...error,
                                title: {
                                    error: descriptionValue === '',
                                    errorMessage: error.title.errorMessage
                                }
                            };
                            setError(newErrorState);
                            setInfor({
                                ...infor,
                                title: descriptionValue
                            });
                        }}
                    />
                    <TextField
                        label="Mô tả"
                        variant="standard"
                        fullWidth
                        margin="dense"
                        required
                        value={infor?.description ?? ""}
                        error={error.description.error}
                        helperText={error.description.error ? error.description.errorMessage : ''}
                        onChange={(e) => {
                            const descriptionValue = e.target.value.trim();
                            const newErrorState = {
                                ...error,
                                description: {
                                    error: descriptionValue === '',
                                    errorMessage: error.description.errorMessage
                                }
                            };
                            setError(newErrorState);
                            setInfor({
                                ...infor,
                                description: e.target.value
                            })
                        }}
                    />
                    <TextField
                        sx={{
                            mt: 3
                        }}
                        select
                        label="Thể loại"
                        fullWidth
                        variant="standard"
                        value={infor?.fk_genre ?? ""}
                        error={error.fk_genre.error}
                        helperText={error.fk_genre.error ? error.fk_genre.errorMessage : ''}
                        onChange={(e) => {
                            const newErrorState = {
                                ...error,
                                fk_genre: {
                                    error: e.target.value ? false : true,
                                    errorMessage: error.fk_genre.errorMessage
                                }
                            };
                            setError(newErrorState);
                            setInfor({
                                ...infor,
                                fk_genre: e.target.value
                            })
                        }}
                    >
                        {genres.map((genre) => (
                            <MenuItem key={genre.id} value={genre.id}>
                                {genre.name}
                            </MenuItem>
                        ))}
                    </TextField>
                    <Button
                        variant="outlined"
                        sx={{
                            mt: 5
                        }}
                        onClick={() => {
                            handleSubmitForm()
                        }}
                    >Save</Button>
                </Grid>
            </Grid>

        </div>
    )
}

export default Step2;