'use client'

import { useEffect, useRef } from "react";
import WaveSurfer from "wavesurfer.js";

const WaveTrack = () => {
    const containerRef = useRef<HTMLInputElement>(null);

    useEffect(() => {
        if (containerRef.current) {
            const wavesurfer = WaveSurfer.create({
                container: containerRef.current,
                waveColor: 'rgb(200, 0, 200)',
                progressColor: 'rgb(100, 0, 100)',
                url: 'http://localhost:8000/static/song/2024/03/Sau_C%C6%A1n_M%C6%B0a_-_CoolKid_ft_Rhyder.mp3',
            })
            wavesurfer.on('click', () => {
                wavesurfer.play()
            })
        }
    }, [])
    return (
        <div ref={containerRef}>
            wave
        </div>
    )
}

export default WaveTrack;