import { Button, Container } from "@mui/material";
import Image from 'next/image';
import './style.css';

const HeadBanner = () => {
    return (
        <Container sx={{ margin: "10px 0px", position: "relative" }}>
            <Image
                src="/sc_landing_header_web_featured_artists-8081257b.jpg"
                width={1240}
                height={465}
                alt="Picture of the author"
                layout="responsive"
            />
            <div className="overlay">
                <h2>Kết nối trên SoundCloud</h2>
                <p>Khám phá, phát trực tuyến và chia sẻ danh sách kết hợp âm nhạc
                    không ngừng mở rộng từ các nghệ sĩ mới nổi và lớn trên khắp thế giới</p>
                <Button variant="contained" style={{ backgroundColor: "#f50" }}>Đăng ký miễn phí</Button>
            </div>
        </Container>
    )
}

export default HeadBanner;