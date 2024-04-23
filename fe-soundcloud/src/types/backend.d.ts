import { IUser } from "./next-auth";

export { };
// https://bobbyhadz.com/blog/typescript-make-types-global#declare-global-types-in-typescript

declare global {
    interface IGenre {
        id: number;
        name: string;
        description: string;
    }

    interface Itembase{
        id: number;
    }


    interface backendResponse{
        access : string;
        refresh : string;
        user: IUser;
    }

    interface ITrack extends Itembase{
        fk_genre: IGenre;
        fk_user: IUser;
        description: string;
        photo: string;
        title:string;
        duration: number;
        url: string;
        like:number;
    }

    interface IRequest {
        url: string;
        method: string;
        body?: { [key: string]: any };
        queryParams?: any;
        useCredentials?: boolean;
        headers?: any;
        nextOption?: any;
    }

    interface IBackendRes<T> {
        error?: string | string[];
        message: string;
        statusCode: number | string;
        results?: T;
    }

    interface IModelPaginate<T> {
        meta: {
            current: number;
            pageSize: number;
            pages: number;
            total: number;
        },
        result: T[]
    }

    interface ITrackContext{
        currentTrack: ITrack;
        setCurrentTrack: (track: ITrack) => void;
    }
}
