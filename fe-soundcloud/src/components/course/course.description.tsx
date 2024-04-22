import { Box } from "@mui/material";
import parse from 'html-react-parser';
import ArticleOutlinedIcon from '@mui/icons-material/ArticleOutlined';

interface IProps {
    description: string;
}

export default function CourseDescription(props: IProps): React.ReactNode {
    return (
        <>
            <Box>
                <div style={{ display: "flex", alignItems: "center", gap: "1rem" }}>
                    <ArticleOutlinedIcon />
                    <h3>Mô tả khóa học</h3>
                </div>
                {props?.description != undefined && parse(props.description)}
            </Box>
        </>

    );
}

