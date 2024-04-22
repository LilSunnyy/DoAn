'use client'
import { useMemo, useState } from 'react';
import { styled } from '@mui/material/styles';
import ArrowForwardIosSharpIcon from '@mui/icons-material/ArrowForwardIosSharp';
import MuiAccordion, { AccordionProps } from '@mui/material/Accordion';
import MuiAccordionSummary, {
    AccordionSummaryProps,
} from '@mui/material/AccordionSummary';
import MuiAccordionDetails from '@mui/material/AccordionDetails';
import Typography from '@mui/material/Typography';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import Box from '@mui/material/Box';
import PlayLessonOutlinedIcon from '@mui/icons-material/PlayLessonOutlined';

interface IProps {
    lesson: ILesson[];
}

const Accordion = styled((props: AccordionProps) => (
    <MuiAccordion disableGutters elevation={0} square {...props} />
))(({ theme }) => ({
    border: `1px solid ${theme.palette.divider}`,
    '&:not(:last-child)': {
        borderBottom: 0,
    },
    '&::before': {
        display: 'none',
    },
}));


const AccordionSummary = styled((props: AccordionSummaryProps) => (
    <MuiAccordionSummary
        expandIcon={<ArrowForwardIosSharpIcon sx={{ fontSize: '0.9rem' }} />}
        {...props}
    />
))(({ theme }) => ({
    backgroundColor:
        theme.palette.mode === 'dark'
            ? 'rgba(255, 255, 255, .05)'
            : 'rgba(0, 0, 0, .03)',
    flexDirection: 'row-reverse',
    '& .MuiAccordionSummary-expandIconWrapper.Mui-expanded': {
        transform: 'rotate(90deg)',
    },
    '& .MuiAccordionSummary-content': {
        marginLeft: theme.spacing(1),
    },
}));


const AccordionDetails = styled(MuiAccordionDetails)(({ theme }) => ({
    padding: theme.spacing(2),
    borderTop: '1px solid rgba(0, 0, 0, .125)',
}));

const ListLesson = (props: IProps) => {
    const totalLesson = props.lesson?.reduce((total, lesson) => {
        total += lesson?.reading.length ?? 0;
        total += lesson?.listening.length ?? 0;
        return total;
    }, 0);

    return (
        <Box>
            <Box>
                <h2 style={{ marginBlockStart: "0.5em", marginBlockEnd: "0.5em" }}>Nội dung khóa học</h2>
                <div style={{ display: "flex", gap: "0.5em", marginBlockEnd: "0.5em", fontWeight: "400", fontSize: "1rem" }}>
                    <span>{props.lesson != undefined && props?.lesson.length} chương -</span>
                    <span>{props?.lesson != undefined && totalLesson} bài học</span>
                </div>
            </Box >
            {
                Array.isArray(props?.lesson) && props?.lesson.map(lesson => {
                    return (
                        <Accordion id={lesson?.id.toString()}>
                            <AccordionSummary
                                aria-controls={`panel-${lesson?.id}-content`}
                                id={`panel-${lesson?.id}-header`}>
                                <Typography>
                                    {lesson?.name}
                                </Typography>
                                <Typography sx={{ ml: 'auto' }}>
                                    {lesson?.listening.length > 0
                                        ? lesson?.listening.length
                                        : lesson?.reading.length}
                                    <span> bài học</span>
                                </Typography>
                            </AccordionSummary>
                            <AccordionDetails>
                                <blockquote style={{
                                    borderLeft: "4px solid rgb(206, 208, 212)",
                                    paddingLeft: "10px",
                                }}>
                                    {lesson?.description}
                                </blockquote>
                                <div style={{ display: "flex", gap: "1rem", flexDirection: "column", marginBlockStart: "2rem" }}>
                                    {lesson?.reading.length > 0 && lesson?.reading.map(reading => {
                                        return (
                                            <div style={{ display: "flex", gap: "10px", alignItems: "center" }}>
                                                <PlayLessonOutlinedIcon />
                                                <span>{reading.name}</span>
                                            </div>
                                        )
                                    })}
                                    {lesson?.listening.length > 0 && lesson?.listening.map(listening => {
                                        return (
                                            <div style={{ display: "flex", gap: "10px", alignItems: "center" }}>
                                                <PlayLessonOutlinedIcon />
                                                <span>{listening.name}</span>
                                            </div>
                                        )
                                    })}
                                </div>
                            </AccordionDetails>
                        </Accordion>
                    )
                })
            }
        </Box>
    );
}

export default ListLesson;