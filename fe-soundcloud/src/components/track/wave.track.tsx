'use client'

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import WaveSurfer from "wavesurfer.js";
import { createRoot } from 'react-dom/client'
import { useWavesurfer } from '@wavesurfer/react';
import './wave.scss'

interface ISlug {
    id: string;
}

const formatTime = (seconds: number) => {
    const minutes = Math.floor(seconds / 60)
    const secondsRemainder = Math.round(seconds) % 60
    const paddedSeconds = `0${secondsRemainder}`.slice(-2)
    return `${minutes}:${paddedSeconds}`
}


const WaveTrack = (slug: ISlug) => {
    const containerRef = useRef<HTMLInputElement>(null);
    const timeRef = useRef<HTMLInputElement>(null);
    const durationRef = useRef<HTMLInputElement>(null);
    const hoverRef = useRef<HTMLInputElement>(null);

    const options = useMemo(() => {
        if (typeof document === 'undefined') {
            return {
                container: containerRef,
                height: 0,
                waveColor: "",
                progressColor: "",
                url: '',
                barWidth: 0,
            };
        }

        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d')!;

        // Define the waveform gradient
        const gradient = ctx.createLinearGradient(0, 0, 0, canvas.height * 1.35);
        gradient.addColorStop(0, '#656666'); // Top color
        gradient.addColorStop((canvas.height * 0.7) / canvas.height, '#656666'); // Top color
        gradient.addColorStop((canvas.height * 0.7 + 1) / canvas.height, '#ffffff'); // White line
        gradient.addColorStop((canvas.height * 0.7 + 2) / canvas.height, '#ffffff'); // White line
        gradient.addColorStop((canvas.height * 0.7 + 3) / canvas.height, '#B1B1B1'); // Bottom color
        gradient.addColorStop(1, '#B1B1B1'); // Bottom color

        // Define the progress gradient
        const progressGradient = ctx.createLinearGradient(0, 0, 0, canvas.height * 1.35);
        progressGradient.addColorStop(0, '#EE772F'); // Top color
        progressGradient.addColorStop((canvas.height * 0.7) / canvas.height, '#EB4926'); // Top color
        progressGradient.addColorStop((canvas.height * 0.7 + 1) / canvas.height, '#ffffff'); // White line
        progressGradient.addColorStop((canvas.height * 0.7 + 2) / canvas.height, '#ffffff'); // White line
        progressGradient.addColorStop((canvas.height * 0.7 + 3) / canvas.height, '#F6B094'); // Bottom color
        progressGradient.addColorStop(1, '#F6B094'); // Bottom color

        return {
            container: containerRef,
            height: 180,
            waveColor: gradient,
            progressColor: progressGradient,
            url: `/api?audio=${slug.id}`,
            barWidth: 3,
        };
    }, []);

    if (containerRef.current !== null && hoverRef.current !== null) {
        const hover = hoverRef.current!
        const waveform = containerRef.current!
        waveform.addEventListener('pointermove', (e) => (hover.style.width = `${e.offsetX}px`))
    }

    const { wavesurfer, isPlaying, currentTime } = useWavesurfer(options)

    const onPlayPause = useCallback(() => {
        wavesurfer && wavesurfer.playPause()
    }, [wavesurfer])

    if (typeof document !== 'undefined') {
        const timeEl = timeRef.current!
        const durationEl = durationRef.current!
        wavesurfer && wavesurfer.on('decode', (duration) => (durationEl.textContent = formatTime(duration)))
        wavesurfer && wavesurfer.on('timeupdate', (currentTime) => (timeEl.textContent = formatTime(currentTime)))
    }

    return (
        <div>
            <div className="wave-form" ref={containerRef}>
                <div className="time" ref={timeRef}>0:00</div>
                <div className="duration" ref={durationRef}>0:00</div>
                <div className="hover-wave" ref={hoverRef}></div>
            </div>
            <button onClick={onPlayPause} style={{ minWidth: '5em' }}>
                {isPlaying ? 'Pause' : 'Play'}
            </button>
        </div>
    )
}

export default WaveTrack;