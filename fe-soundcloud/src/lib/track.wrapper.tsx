'use client';

import { createContext, useContext, useState } from "react";

const TrackContext = createContext<ITrackContext | null>(null)

export const TrackContextProvider = ({ children }: { children: React.ReactNode }) => {
    const initValue = {
        id: 0,
        fk_genre: { id: 0, name: "", description: "" },
        fk_user: { id: 0, username: "", password: "", email: "", first_name: "", last_name: "", avatar: "" },
        description: "",
        photo: "",
        title: "",
        duration: 0,
        url: "",
        like: 0
    }
    const [currentTrack, setCurrentTrack] = useState<ITrack>(initValue);

    return (
        <TrackContext.Provider value={{ currentTrack, setCurrentTrack }}>
            {children}
        </TrackContext.Provider>
    )
};

export const useCourseContext = () => useContext(TrackContext);