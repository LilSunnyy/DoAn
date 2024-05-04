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

function LinearWithValueLabel(trackUpload: IProps) {

    return (
        <Box sx={{ width: '100%' }}>
            <LinearProgressWithLabel value={trackUpload.trackUpload.percent} />
        </Box>
    );
}
interface TabPanelProps {
    children?: React.ReactNode;
    index: number;
    value: number;
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

function InputFileUpload() {
    return (
        <Button
            onClick={(e) => e.preventDefault()}
            component="label" variant="contained" startIcon={<CloudUploadIcon />}>
            Upload file
            <VisuallyHiddenInput type="file" />
        </Button>
    );
}

function CustomTabPanel(props: TabPanelProps) {
    const { children, value, index, ...other } = props;

    return (
        <div
            role="tabpanel"
            hidden={value !== index}
            id={`simple-tabpanel-${index}`}
            aria-labelledby={`simple-tab-${index}`}
            {...other}
        >
            {value === index && (
                <Box sx={{ p: 3 }}>
                    {children}
                </Box>
            )}
        </div>
    );
}

interface IProps {
    trackUpload: {
        fileName: string;
        percent: number;
        id: number;
    }
}

interface INewTrack {
    fk_genre: string;
    description: string;
    photo: string;
    title: string;
    url: string;
}

const Step2 = (props: IProps) => {
    const [infor, setInfor] = useState<INewTrack>({
        fk_genre: "",
        description: "",
        photo: "",
        title: "",
        url: ""
    })
    const category = [
        {
            value: 'CHILL',
            label: 'CHILL',
        },
        {
            value: 'WORKOUT',
            label: 'WORKOUT',
        },
        {
            value: 'PARTY',
            label: 'PARTY',
        }
    ];

    return (
        <div>
            <div>
                <div>
                    {props.trackUpload.fileName}
                </div>
                <LinearWithValueLabel
                    trackUpload={props.trackUpload}
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
                        <div>

                        </div>

                    </div>
                    <div >
                        <InputFileUpload />
                    </div>

                </Grid>
                <Grid item xs={6} md={8}>
                    <TextField
                        label="Title"
                        variant="standard"
                        fullWidth margin="dense"
                        value={props.trackUpload.fileName.split('.').slice(0, -1).join('.')}
                        onChange={(e) => {
                            setInfor({
                                ...infor,
                                title: e.target.value
                            })
                        }}
                    />
                    <TextField
                        label="Description"
                        variant="standard"
                        fullWidth
                        margin="dense"
                        value={infor?.description ?? ""}
                        onChange={(e) => {
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
                        label="Category"
                        fullWidth
                        variant="standard"
                        value={infor?.fk_genre ?? ""}
                        onChange={(e) => {
                            setInfor({
                                ...infor,
                                fk_genre: e.target.value
                            })
                        }}
                    >
                        {category.map((option) => (
                            <MenuItem key={option.value} value={option.value}>
                                {option.label}
                            </MenuItem>
                        ))}
                    </TextField>
                    <Button
                        variant="outlined"
                        sx={{
                            mt: 5
                        }}>Save</Button>
                </Grid>
            </Grid>

        </div>
    )
}

export default Step2;