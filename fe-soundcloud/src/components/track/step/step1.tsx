'use client'

import { FileWithPath, useDropzone } from 'react-dropzone'
import './dropzone.scss'
import InputFileButton from './button/upload.button';
import { useCallback } from 'react';

const Step1 = () => {
    const onDrop = useCallback((acceptedFiles: FileWithPath[]) => {
        // Do something with the files
    }, [])

    const { acceptedFiles, getRootProps, getInputProps, isDragActive } = useDropzone({ onDrop });

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