'use client'

import { FileWithPath, useDropzone } from 'react-dropzone'
import './dropzone.scss'
import InputFileButton from './button/upload.button';
import { useCallback } from 'react';
import { sendRequest } from '@/utils/api';
import { useSession } from 'next-auth/react';
import axios, { AxiosProgressEvent } from 'axios';

const Step1 = () => {
    const { data: session } = useSession();
    const config = {
        headers: {
            'Content-Type': 'multipart/form-data', // Thêm dòng này để Axios biết là bạn đang gửi FormData
            'Authorization': `Bearer ${session?.access_token}`,
            "target-type": "audio",
        },
        onUploadProgress: (progressEvent: AxiosProgressEvent) => {
            let percentCompleted = Math.floor((progressEvent.loaded * 100) / progressEvent.total!);
            console.log(percentCompleted)
        }
    };
    const onDrop = useCallback(async (acceptedFiles: FileWithPath[]) => {
        if (acceptedFiles && acceptedFiles[0]) {
            const audio = acceptedFiles[0];
            const formData = new FormData();
            formData.append('url', audio)

            try {
                const res = await axios.post('http://localhost:8000/tracks/', formData, config
                )
                console.log(res.data)
            } catch (error) {
                //@ts-ignore
                alert(error?.response?.data)
            }
        }
    }, [session])

    const { acceptedFiles, getRootProps, getInputProps, isDragActive } = useDropzone({
        onDrop,
        // accept: {
        //     'audio': ['mp3']
        // }
    });

    const files = acceptedFiles.map((file: FileWithPath) => (
        <li key={file.path}>
            {file.path} - {file.size} bytes
        </li>
    ));

    return (
        <section className="container">
            <div {...getRootProps({ className: 'dropzone' })}>
                <input {...getInputProps()} />
                <InputFileButton />
                <p>Drag 'n' drop some files here, or click to select files</p>
            </div>
            <aside>
                <h4>Files</h4>
                <ul>{files}</ul>
            </aside>
        </section>
    )
}

export default Step1;