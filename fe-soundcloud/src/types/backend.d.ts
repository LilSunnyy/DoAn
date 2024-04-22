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
        created_date: string;
        updated_date:string;
        is_active: boolean;
    }

    interface IListening extends Itembase{
        sound: string;
        fk_lesson: string;
    }

    interface IReading extends Itembase{
        paragraph: string;
        fk_lesson: string;
    }

    interface ILesson extends Itembase{
        description: string;
        fk_course: number;
        reading: IReading[];
        listening: IListening[];
    }

    interface backendResponse{
        access : string;
        refresh : string;
        user: IUser;
    }

    interface ITrack extends Itembase{
        fk_genre: number;
        fk_user: number;
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

    interface ICourseContext{
        currentCourse: ICourse;
        setCurrentCourse: (course: ICourse) => void;
    }
}
