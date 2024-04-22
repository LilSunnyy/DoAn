"use client"
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
import Slider from "react-slick";
import { Settings } from "react-slick";
import { Box, Button } from "@mui/material";
import Divider from "@mui/material/Divider";
import ChevronRightIcon from "@mui/icons-material/ChevronRight";
import ChevronLeftIcon from "@mui/icons-material/ChevronLeft";
import Link from "next/link";
import { convertSlugUrl } from "@/utils/api";

interface IProps {
    results: ICourse[]
}

const MainSlider = (props: IProps) => {
    const { results } = props;

    const NextArrow = (props: any) => {
        return (
            <Button color="inherit" variant="contained" onClick={props.onClick}
                sx={{
                    position: "absolute",
                    right: 40,
                    top: "25%",
                    zIndex: 2,
                    minWidth: 30,
                    width: 35
                }}>
                <ChevronRightIcon />
            </Button>
        )
    }

    const PrevArrow = (props: any) => {
        return (
            <Button color="inherit" variant="contained" onClick={props.onClick}
                sx={{
                    position: "absolute",
                    top: "25%",
                    zIndex: 2,
                    minWidth: 30,
                    width: 35
                }}>
                <ChevronLeftIcon />
            </Button>
        )
    }

    const settings: Settings = {
        dots: true,
        infinite: true,
        speed: 500,
        slidesToShow: 5,
        nextArrow: <NextArrow />,
        prevArrow: <PrevArrow />,
        slidesToScroll: 1,
        autoplay: true,
    };
    return (
        <Box sx={{
            margin: "0 50px",
            ".course": {
                padding: "0 10px",
                "img": {
                    height: 150,
                    width: 150
                }
            },
            "h3": {
                border: "1px solid #ccc",
                padding: "20px",
                height: "200px",
            }
        }}>
            <h2>Tieu de</h2>
            <Slider {...settings}>
                {Array.isArray(results) && results.map(course => {
                    return (
                        <div className="course" key={course.id}>
                            <Link href={`/course/${convertSlugUrl(course?.name)}-${course?.id}.html?tag=${course?.tag[0]?.name}`}>
                                <img src={`${process.env.NEXT_PUBLIC_BACKEND_URL}/static/${course?.image}`} alt="course" />
                                <h4>{course.name}</h4>
                            </Link>
                        </div>
                    )
                })
                }
            </Slider>
        </Box>
    );
}
export default MainSlider;